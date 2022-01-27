import 'dart:async';

import 'package:flutter/material.dart';
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
  final CreateRoute _createRoute;
  final UuidGeneratorService _uuidGeneratorService;
  final GeolocatorService _geolocatorService;
  final ImagePickerService _imagePickerService;
  final CalculatePointsDistance _calculatePointsDistance;
  final GenerateNewPolyline _generateNewPolyline;
  final AddUserXp _addUserXp;
  final RouteViewModel _routeViewModel;

  late GoogleMapController mapController;
  late RouteProgressData _routeProgressData;
  late Timer _saveRouteInterval;
  late Timer _drawRouteInterval;
  final Map<PolylineId, Polyline> _polylines = {};
  final List<LatLng> _polylinePointList = [];
  Position _currentPosition = GeoPointUtils.defautLocation;
  Position? _lastPosition;
  double _currentZoom = 3;
  bool _hasStartedRoute = false;
  String _errorMessage = "";

  late StreamSubscription<Position> _positionListener;
  late StreamSubscription<ServiceStatus> _statusListener;
  ServiceStatus _serviceStatus = ServiceStatus.disabled;

  StartPloggingPageViewModel(
      AuthenticationService authenticationService,
      this._createRoute,
      this._geolocatorService,
      this._uuidGeneratorService,
      this._imagePickerService,
      this._routeProgressData,
      this._calculatePointsDistance,
      this._generateNewPolyline,
      this._addUserXp,
      this._routeViewModel)
      : super(authenticationService);

  @override
  loadPage() {
    createConnectionStatusListener();
    //createPositionListener();
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  createListeners() {
    createDrawRouteInterval();
    createSaveRouteInterval();
  }

  removeListeners() {
    _saveRouteInterval.cancel();
    _drawRouteInterval.cancel();
  }

  createPositionListener() {
    _positionListener = _geolocatorService
        .getStreamLocationPosition()
        .listen((Position position) {
      _currentPosition = position;
      setCameraToCurrentLocation();
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  createConnectionStatusListener() {
    _statusListener = _geolocatorService
        .getStreamLocationStatus()
        .listen((ServiceStatus status) async {
      _serviceStatus = status;
      await setCameraToCurrentLocation(first: true);
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

  updatePoints() {
    saveInPointList();
    setLastPosition();
  }

  createDrawRouteInterval() {
    _drawRouteInterval = Timer.periodic(
        const Duration(seconds: AppConstants.secondsToDraw), (_) async {
      _currentPosition = Position(
          accuracy: _currentPosition.accuracy,
          altitude: _currentPosition.altitude,
          heading: _currentPosition.heading,
          latitude: _currentPosition.latitude + 0.0002,
          longitude: _currentPosition.longitude + 0.0002,
          speed: 1,
          speedAccuracy: 5.0,
          timestamp: DateTime.now());
      if (!hasMinDistance(AppConstants.minDistanceToDraw)) return;
      addPolyline();
      setCameraToCurrentLocation();
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  beginRoute() async {
    if (!await setCameraToCurrentLocation()) {
      return;
    }
    createListeners();
    _routeProgressData.startProgressData(currentUser.id);
    toggleRouteStatus(status: true);
    updatePoints();
    notifyListeners(StartPloggingNotifiers.updatePloggingPage);
  }

  endRoute() {
    if (!_hasStartedRoute) return;
    removeListeners();
    completeProgressRouteData();
    toggleRouteStatus(status: false);
    if (validateRoute()) {
      notifyListeners(StartPloggingNotifiers.confirmRoutePlogging);
    }
  }

  validateRoute() {
    if (!_routeViewModel.validateRoute(
        _routeProgressData.distance!, _routeProgressData.duration!)) {
      _errorMessage = _routeViewModel.errorMessage;
      notifyListeners(StartPloggingNotifiers.errorRoutePlogging);
      return false;
    }
    return true;
  }

  Future<void> confirmRoute() async {
    _routeProgressData.confirmProgressData();
    await _createRoute.execute(_routeProgressData);
    await _addUserXp.execute(_routeProgressData);
    dismissAlert();
    notifyListeners(StartPloggingNotifiers.updatePloggingPage);
  }

  completeProgressRouteData() {
    final distance = _calculatePointsDistance.execute(_polylinePointList);
    _routeProgressData.completeProgressData(distance, _polylinePointList);
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
    _polylines.addAll({polyline.polylineId: polyline});
  }

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await _geolocatorService.getCurrentLocation();
    } catch (_) {
      _errorMessage = "Error getting location";
    }
  }

  getAndSetCurrentLocation() async {
    await getCurrentLocation()
        .then((value) async => await setCameraToPosition(_currentPosition));
  }

  Future<void> isLocationActive() async {
    return await _geolocatorService.validateLocationService().then((value) {
      _serviceStatus = value ? ServiceStatus.enabled : ServiceStatus.disabled;
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  Future<bool> setCameraToCurrentLocation({bool first = false}) async {
    if (first) await isLocationActive();
    if (_serviceStatus == ServiceStatus.enabled && first) {
      getAndSetCurrentLocation();
      return true;
    }
    if (_serviceStatus == ServiceStatus.disabled) {
      getCurrentLocation();
      return false;
    }
    setCameraToPosition(_currentPosition);
    return true;
  }

  setCameraToPosition(Position position, {double zoom = 18.0}) {
    _currentZoom = zoom;
    final CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: _currentZoom,
        bearing: _currentPosition.heading,
        tilt: 45.0);
    animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  zoomOut() {
    animateCamera(CameraUpdate.zoomOut());
  }

  zoomIn() {
    animateCamera(CameraUpdate.zoomIn());
  }

  animateCamera(CameraUpdate cameraUpdate) {
    mapController.animateCamera(cameraUpdate);
  }

  void dismissAlert() {
    _routeProgressData =
        RouteProgressData(id: _uuidGeneratorService.generate());
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

  Map<PolylineId, Polyline> get polylines {
    return _polylines;
  }

  String get errorMessage {
    return _errorMessage;
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
