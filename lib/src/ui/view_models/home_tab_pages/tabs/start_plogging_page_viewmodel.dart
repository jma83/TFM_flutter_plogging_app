import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/application/route/calculate_points_direction.dart';
import 'package:flutter_plogging/src/core/application/route/calculate_points_distance.dart';
import 'package:flutter_plogging/src/core/application/route/create_route.dart';
import 'package:flutter_plogging/src/core/application/route/generate_new_polyline.dart';
import 'package:flutter_plogging/src/core/application/user/add_user_xp.dart';
import 'package:flutter_plogging/src/core/domain/route/route_progress_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/start_plogging_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/route/route_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/app_constants.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
/* 
      _currentPosition = Position(
          accuracy: _currentPosition.accuracy,
          altitude: _currentPosition.altitude,
          heading: _currentPosition.heading,
          latitude: _currentPosition.latitude + 0.0002,
          longitude: _currentPosition.longitude + 0.0002,
          speed: 1,
          speedAccuracy: 5.0,
          timestamp: DateTime.now());
*/

@injectable
class StartPloggingPageViewModel extends HomeTabsChangeNotifier {
  // Services and Use cases
  final CreateRoute _createRoute;
  final UuidGeneratorService _uuidGeneratorService;
  final GeolocatorService _geolocatorService;
  final ImagePickerService _imagePickerService;
  final CalculatePointsDistance _calculatePointsDistance;
  final CalculatePointsDirection _calculatePointsDirection;
  final GenerateNewPolyline _generateNewPolyline;
  final AddUserXp _addUserXp;
  final RouteViewModel _routeViewModel;

  // ViewModel state attributes
  late GoogleMapController mapController;
  late RouteProgressData _routeProgressData;
  late Timer _saveRouteInterval;
  final List<Polyline> _polylines = [];
  final List<LatLng> _polylinePointList = [];
  Position? _lastPosition;
  double _currentZoom = 3;
  double _currentDirection = 0;
  bool _hasStartedRoute = false;
  String? _errorMessage;
  ServiceStatus _serviceStatus = ServiceStatus.disabled;
  Position _currentPosition = GeoPointUtils.defautLocation;

  // Stream listeners
  late StreamSubscription<Position> _positionListener;
  late StreamSubscription<ServiceStatus> _statusListener;

  StartPloggingPageViewModel(
      AuthenticationService authenticationService,
      this._createRoute,
      this._geolocatorService,
      this._uuidGeneratorService,
      this._imagePickerService,
      this._routeProgressData,
      this._calculatePointsDistance,
      this._calculatePointsDirection,
      this._generateNewPolyline,
      this._addUserXp,
      this._routeViewModel)
      : super(authenticationService);

  @override
  loadPage() {
    createConnectionStatusListener();
    createPositionListener();
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  createRouteListeners() {
    createSaveRouteInterval();
  }

  removeListeners() {
    _saveRouteInterval.cancel();
  }

  createPositionListener() {
    _positionListener = _geolocatorService
        .getStreamLocationPosition()
        .listen((Position position) async {
      if (!isServiceEnabled) return;
      if (hasStartedRoute) {
        draw();
        updateDirection(
            firstPosition: _currentPosition, secondPosition: position);
        await setCameraToCurrentLocation();
      }
      _currentPosition = position;
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  Future<void> draw() async {
    if (!hasMinDistance(AppConstants.minDistanceToSave)) return;
    addPolyline();
    await setCameraToCurrentLocation();
  }

  createConnectionStatusListener() {
    _statusListener = _geolocatorService
        .getStreamLocationStatus()
        .listen((ServiceStatus status) async {
      _serviceStatus = status;
      if (isServiceEnabled) await setCameraToCurrentLocation(first: true);
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  createSaveRouteInterval() {
    _saveRouteInterval = Timer.periodic(
        const Duration(seconds: AppConstants.secondsToSave), (_) async {
      if (!hasMinDistance(AppConstants.minDistanceToSave)) return;
      updatePoints();
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  beginRoute() async {
    if (_hasStartedRoute) return;
    _currentZoom = 18;
    if (!await setCameraToCurrentLocation()) return;
    createRouteListeners();
    _routeProgressData.startProgressData(currentUser.id);
    toggleRouteStatus(status: true);
    updatePoints();
    notifyListeners(StartPloggingNotifiers.updatePloggingPage);
  }

  endRoute() {
    if (!_hasStartedRoute) return;
    removeListeners();
    updatePoints();
    completeProgressRouteData();
    toggleRouteStatus(status: false);
    validateRoute();
  }

  updatePoints() {
    saveInPointList();
    setLastPosition();
  }

  updateDirection(
      {required Position firstPosition, required Position secondPosition}) {
    if (_lastPosition! != _currentPosition) {
      firstPosition = _lastPosition!;
      secondPosition = _currentPosition;
    }
    _currentDirection = _calculatePointsDirection
        .executeByPositions([firstPosition, secondPosition]);
  }

  validateRoute() {
    if (!_routeViewModel.validateRoute(
        _routeProgressData.distance!, _routeProgressData.duration!)) {
      _errorMessage = _routeViewModel.errorMessage;
      return notifyListeners(StartPloggingNotifiers.errorRoutePlogging);
    }
    return notifyListeners(StartPloggingNotifiers.confirmRoutePlogging);
  }

  Future<void> confirmRoute() async {
    _routeProgressData.confirmProgressData();
    await _createRoute.execute(_routeProgressData);
    final int currentLevel = currentUser.level;
    _errorMessage = await _addUserXp.execute(_routeProgressData);
    if (_errorMessage != null) {
      return notifyListeners(StartPloggingNotifiers.errorRoutePlogging);
    }
    dismissAlert();
    if (currentLevel != currentUser.level) {
      return notifyListeners(StartPloggingNotifiers.userLevelUp);
    }
    notifyListeners(StartPloggingNotifiers.updatePloggingPage);
  }

  completeProgressRouteData() {
    final distance = _calculatePointsDistance.execute(_polylinePointList);
    _routeProgressData.completeProgressData(distance, _polylinePointList);
    _currentDirection = 0;
    _lastPosition = null;
    _polylinePointList.clear();
    _polylines.clear();
  }

  toggleRouteStatus({bool status = false}) {
    _hasStartedRoute = status;
  }

  saveInPointList() {
    _polylinePointList
        .add(GeoPointUtils.getLatLongFromPostion(_currentPosition));
  }

  setLastPosition() {
    _lastPosition = _currentPosition;
  }

  hasMinDistance(int minDistance) {
    final double distance = _calculatePointsDistance
        .executeByPositions([_lastPosition!, _currentPosition]);
    if (distance < minDistance) return false;
    return true;
  }

  void addPolyline() {
    final Polyline polyline = _generateNewPolyline.executeNew([
      GeoPointUtils.getLatLongFromPostion(_lastPosition!),
      GeoPointUtils.getLatLongFromPostion(_currentPosition)
    ], Colors.red);
    _polylines.add(polyline);
  }

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await _geolocatorService.getCurrentLocation();
    } catch (_) {
      _errorMessage = "Error getting location";
    }
  }

  getAndSetCurrentLocation() async {
    await getCurrentLocation().then(
        (value) async => await setCameraToPosition(_currentPosition, zoom: 18));
  }

  Future<void> isLocationActive() async {
    _serviceStatus = await _geolocatorService.validateLocationService()
        ? ServiceStatus.enabled
        : ServiceStatus.disabled;
    notifyListeners(StartPloggingNotifiers.updatePloggingPage);
  }

  Future<bool> setCameraToCurrentLocation({bool first = false}) async {
    if (first) await isLocationActive();
    if (_serviceStatus == ServiceStatus.enabled && first) {
      getAndSetCurrentLocation();
      return true;
    }
    if (_serviceStatus == ServiceStatus.disabled) {
      if (!first) {
        getCurrentLocation();
      }
      return false;
    }
    setCameraToPosition(_currentPosition, zoom: first ? 18 : null);
    return true;
  }

  setCameraToPosition(Position position, {double? zoom}) {
    CameraPosition cameraPosition;
    if (zoom != null) _currentZoom = zoom;
    cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: _currentZoom,
        bearing: _currentDirection,
        tilt: 45.0);
    animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  zoomOut() async {
    await animateCamera(CameraUpdate.zoomOut());
    if (_currentZoom > 0) _currentZoom--;
  }

  zoomIn() async {
    await animateCamera(CameraUpdate.zoomIn());
    if (_currentZoom < 20) _currentZoom++;
  }

  Future<void> animateCamera(CameraUpdate cameraUpdate) async {
    return await mapController.animateCamera(cameraUpdate);
  }

  void dismissAlert({bool resetRoute = true}) {
    if (resetRoute) {
      _routeProgressData =
          RouteProgressData(id: _uuidGeneratorService.generate());
    }
    notifyListeners(StartPloggingNotifiers.returnToPrevious);
  }

  // Modal confirmation data
  setRouteName(String name) {
    _routeProgressData.name = name;
  }

  setRouteDescription(String description) {
    _routeProgressData.description = description;
  }

  void setRouteImage(XFile? image) {
    _routeProgressData.image = image?.path;
  }

  Future<XFile?> uploadRouteImage(ImageSource imageSource) async {
    final XFile? image = await _imagePickerService.pickImage(imageSource);
    setRouteImage(image);
    return image;
  }

  bool get hasStartedRoute {
    return _hasStartedRoute;
  }

  Position get currentPosition {
    return _currentPosition;
  }

  double get currentZoom {
    return _currentZoom;
  }

  List<Polyline> get polylines {
    return _polylines;
  }

  String get errorMessage {
    return _errorMessage ?? "";
  }

  bool get isServiceEnabled {
    return _serviceStatus == ServiceStatus.enabled;
  }

  @override
  void dispose() {
    if (authenticationService.currentUserData == null) {
      super.dispose();
      _positionListener.cancel();
      _statusListener.cancel();
    }
  }
}
