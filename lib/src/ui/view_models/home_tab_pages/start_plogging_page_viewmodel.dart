import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
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

const int minDistance = 10;

final Position defautLocation = Position(
    accuracy: 1.0,
    altitude: 0,
    heading: 0,
    latitude: 0,
    longitude: 0,
    speed: 0,
    speedAccuracy: 1.0,
    timestamp: DateTime.now());

@injectable
class StartPloggingPageViewModel extends HomeTabsChangeNotifier {
  final RouteStoreService _routeStoreService;
  final UiidGeneratorService _uiidGeneratorService;
  final GeolocatorService _geolocatorService;
  final ImagePickerService _imagePickerService;
  Function? funRef;

  late GoogleMapController mapController;
  ServiceStatus serviceStatus = ServiceStatus.disabled;
  Position _currentPosition = defautLocation;
  Position? lastPosition;
  double currentZoom = 3;
  Timestamp? startDate;
  String? routeName;
  String? routeDescription;
  Image? routeImage;

  List<LatLng> polylinePointList = [];
  Map<PolylineId, Polyline> polylines = {};

  StartPloggingPageViewModel(
      AuthenticationService authenticationService,
      this._routeStoreService,
      this._geolocatorService,
      this._uiidGeneratorService,
      this._imagePickerService)
      : super(authenticationService);

  bool _hasStartedRoute = false;

  createListeners() {
    // createPositionListener();
    createDisconnectionListener();
  }

  createPositionListener() {
    _geolocatorService.getStreamLocationPosition().listen((Position position) {
      _currentPosition = position;
      print(
          "update position ${_currentPosition.latitude} ${_currentPosition.longitude}");
      notifyListeners("update_start_plogging_page");
    });
  }

  createDisconnectionListener() {
    _geolocatorService.getStreamLocationStatus().listen((ServiceStatus status) {
      serviceStatus = status;
      setCameraToCurrentLocation(first: true);
    });
  }

  beginRoute() {
    setStartDate();
    createDrawRouteInterval();
    toggleRouteStatus();
    setLastPosition();
    notifyListeners("update_start_plogging_page");
  }

  endRoute() {
    if (!_hasStartedRoute) return;
    toggleRouteStatus();
    notifyListeners("update_start_plogging_confirm_route");
  }

  confirmRoute() {
    _routeStoreService.addElement(
        RouteData(
            name: "Example",
            description: "Description example",
            distance:
                _geolocatorService.calculateFullDistance(polylinePointList),
            locationArray: convertLatLngToGeopoints(),
            endDate: Timestamp.now(),
            duration: calcDateDifference(startDate!, Timestamp.now()),
            startDate: startDate,
            userId: authenticationService.currentUser!.uid),
        _uiidGeneratorService.generate());
    notifyListeners("update_start_plogging_page");
  }

  List<GeoPoint>? convertLatLngToGeopoints() {
    return polylinePointList
        .map((element) => GeoPoint(element.latitude, element.longitude))
        .toList();
  }

  toggleRouteStatus() {
    _hasStartedRoute = !_hasStartedRoute;
  }

  setLastPosition() {
    lastPosition = _currentPosition;
  }

  setStartDate() {
    startDate = Timestamp.now();
  }

  setRouteName(String name) {
    routeName = name;
  }

  setRouteDescription(String description) {
    routeDescription = description;
  }

  setRouteImage(Image image) {
    routeImage = image;
  }

  calcDateDifference(Timestamp t1, Timestamp t2) {
    DateTime dateTime1 = DateTime.parse(t1.toDate().toString());
    DateTime dateTime2 = DateTime.parse(t2.toDate().toString());
    return dateTime2.difference(dateTime1).inSeconds;
  }

  createDrawRouteInterval() {
    Timer.periodic(const Duration(seconds: 5), (_) async {
      if (!hasMinDistanceToDraw()) return;
      addPolyline();
      setLastPosition();
      notifyListeners("update_start_plogging_page");
    });
  }

  hasMinDistanceToDraw() {
    final double distance =
        _geolocatorService.calculateDistance(lastPosition!, _currentPosition);
    if (distance < minDistance) return false;
    return true;
  }

  Future<void> addPolyline() async {
    final PolylineId polylineId = PolylineId(_uiidGeneratorService.generate());
    final int lastLength = polylinePointList.length;

    polylinePointList = await _geolocatorService.createPolylines(
        polylinePointList, lastPosition!, _currentPosition);
    if (lastLength != polylinePointList.length) return;
    polylines[polylineId] =
        _geolocatorService.generatePolyline(polylineId, polylinePointList);
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await _geolocatorService.getCurrentLocation();
    } catch (e) {
      print("error getting location $e");
    }
  }

  getAndSetCurrentLocation() async {
    getCurrentLocation()
        .then((value) async => await setCameraToPosition(_currentPosition));
  }

  Future<void> isLocationActive() async {
    return await _geolocatorService.validateLocationService().then((value) {
      serviceStatus = value ? ServiceStatus.enabled : ServiceStatus.disabled;
    });
  }

  Future<void> setCameraToCurrentLocation({bool first = false}) async {
    if (first) await isLocationActive();
    if (serviceStatus == ServiceStatus.enabled && first) {
      getAndSetCurrentLocation();
      return;
    }
    if (serviceStatus == ServiceStatus.disabled) {
      getCurrentLocation();
      return;
    }
    setCameraToPosition(_currentPosition);
  }

  setCameraToPosition(Position position, {double zoom = 18.0}) {
    currentZoom = zoom;
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: currentZoom,
    );
    animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  pickImageFromCamera() {
    _imagePickerService.pickImage(ImageSource.camera);
  }

  pickImageFromGallery() {
    _imagePickerService.pickImage(ImageSource.gallery);
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
    notifyListeners("startPloggingRouteCoordinator_returnToPrevious");
  }

  bool get hasStartedRoute {
    return _hasStartedRoute;
  }

  Position get currentPosition {
    return _currentPosition;
  }
}
