import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  late Timer routeInterval;
  bool _hasStartedRoute = false;
  String _errorMessage = "";

  late StreamSubscription<Position> positionListener;
  late StreamSubscription<ServiceStatus> statusListener;

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
    createPositionListener();
  }

  createListeners() {
    createDrawRouteInterval();
  }

  removeListeners() {
    routeInterval.cancel();
  }

  createPositionListener() {
    positionListener = _geolocatorService
        .getStreamLocationPosition()
        .listen((Position position) {
      _routeProgressData.currentPosition = position;
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  createConnectionStatusListener() {
    statusListener = _geolocatorService
        .getStreamLocationStatus()
        .listen((ServiceStatus status) {
      _routeProgressData.serviceStatus = status;
      setCameraToCurrentLocation(first: true);
      notifyListeners(StartPloggingNotifiers.updatePloggingPage);
    });
  }

  createDrawRouteInterval() {
    routeInterval = Timer.periodic(
        const Duration(seconds: AppConstants.secondsToDraw), (_) async {
      if (!hasMinDistanceToDraw()) return;
      addPolyline();
      saveInPointList();
      setLastPosition();
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
    setLastPosition();
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
    final distance =
        _calculatePointsDistance.execute(_routeProgressData.polylinePointList);
    _routeProgressData.completeProgressData(distance);
  }

  toggleRouteStatus({bool status = false}) {
    _hasStartedRoute = status;
  }

  saveInPointList() {
    _routeProgressData.polylinePointList.add(
        GeoPointUtils.getLatLongFromPostion(
            _routeProgressData.currentPosition));
  }

  setLastPosition() {
    _routeProgressData.lastPosition = _routeProgressData.currentPosition;
  }

  hasMinDistanceToDraw() {
    final double distance = _calculatePointsDistance.executeByPositions(
        [_routeProgressData.lastPosition!, _routeProgressData.currentPosition]);
    if (distance < AppConstants.minDistance) return false;
    return true;
  }

  void addPolyline() {
    final Polyline polyline = _generateNewPolyline.executeNew([
      GeoPointUtils.getLatLongFromPostion(_routeProgressData.lastPosition!),
      GeoPointUtils.getLatLongFromPostion(_routeProgressData.currentPosition)
    ], Colors.red);
    _routeProgressData.polylines.addAll({polyline.polylineId: polyline});
  }

  Future<void> getCurrentLocation() async {
    try {
      _routeProgressData.currentPosition =
          await _geolocatorService.getCurrentLocation();
    } catch (e) {
      _errorMessage = "Error getting location";
      notifyListeners(StartPloggingNotifiers.errorRoutePlogging);
    }
  }

  getAndSetCurrentLocation() async {
    getCurrentLocation().then((value) async =>
        await setCameraToPosition(_routeProgressData.currentPosition));
  }

  Future<void> isLocationActive() async {
    return await _geolocatorService.validateLocationService().then((value) {
      _routeProgressData.serviceStatus =
          value ? ServiceStatus.enabled : ServiceStatus.disabled;
    });
  }

  Future<bool> setCameraToCurrentLocation({bool first = false}) async {
    if (first) await isLocationActive();
    if (_routeProgressData.serviceStatus == ServiceStatus.enabled && first) {
      getAndSetCurrentLocation();
      return true;
    }
    if (_routeProgressData.serviceStatus == ServiceStatus.disabled) {
      getCurrentLocation();
      return false;
    }
    setCameraToPosition(_routeProgressData.currentPosition);
    return true;
  }

  setCameraToPosition(Position position, {double zoom = 18.0}) {
    _routeProgressData.currentZoom = zoom;
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: _routeProgressData.currentZoom,
    );
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
    _routeProgressData = RouteProgressData(
        id: _uuidGeneratorService.generate(),
        currentZoom: _routeProgressData.currentZoom,
        currentPosition: _routeProgressData.currentPosition,
        serviceStatus: _routeProgressData.serviceStatus);
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

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
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
    return _routeProgressData.currentPosition;
  }

  double get currentZoom {
    return _routeProgressData.currentZoom;
  }

  Map<PolylineId, Polyline> get polylines {
    return _routeProgressData.polylines;
  }

  String get errorMessage {
    return _errorMessage;
  }
}
