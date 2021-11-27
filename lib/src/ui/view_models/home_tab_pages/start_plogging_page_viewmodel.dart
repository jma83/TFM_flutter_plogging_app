import 'dart:async';

import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late GoogleMapController mapController;
  ServiceStatus serviceStatus = ServiceStatus.disabled;
  Position currentPosition = defautLocation;
  Position? lastPosition;
  double currentZoom = 3;
  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  StartPloggingPageViewModel(
      AuthenticationService authenticationService,
      this._routeStoreService,
      this._geolocatorService,
      this._uiidGeneratorService)
      : super(authenticationService);

  bool _hasStartedRoute = false;

  createListeners() {
    createPositionListener();
    createDisconnectionListener();
  }

  createPositionListener() async {
    _geolocatorService.getStreamLocationPosition().listen((Position position) {
      currentPosition = position;
    });
  }

  createDisconnectionListener() {
    _geolocatorService.getStreamLocationStatus().listen((ServiceStatus status) {
      serviceStatus = status;
      setCameraToCurrentLocation(first: true);
    });
  }

  beginRoute() {
    _hasStartedRoute = true;
    lastPosition = currentPosition;
    Timer.periodic(const Duration(seconds: 5), (_) {
      _geolocatorService.createPolylines(
          polylineCoordinates,
          lastPosition!.latitude,
          lastPosition!.longitude,
          currentPosition.latitude,
          currentPosition.longitude,
          _uiidGeneratorService.generate());
      // _geolocatorService.createPolylines(polylineCoordinates, )
    });
    notifyListeners("update_start_plogging_page");
  }

  endRoute() {
    if (!_hasStartedRoute) {
      return;
    }
    _hasStartedRoute = false;
    _routeStoreService.addElement(
        RouteData(
            name: "Example",
            description: "Description example",
            userId: authenticationService.currentUser!.uid),
        _uiidGeneratorService.generate());
    notifyListeners("update_start_plogging_page");
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  Future<void> getCurrentLocation() async {
    try {
      currentPosition = await _geolocatorService.getCurrentLocation();
      print("location!!! $currentPosition");
    } catch (e) {
      print("error getting location $e");
    }
  }

  getAndSetCurrentLocation() async {
    getCurrentLocation()
        .then((value) async => await setCameraToPosition(currentPosition));
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
    setCameraToPosition(currentPosition);
  }

  setCameraToPosition(Position position, {double zoom = 18.0}) {
    currentZoom = zoom;
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: currentZoom,
    );
    final CameraUpdate cameraUpdate =
        CameraUpdate.newCameraPosition(cameraPosition);
    mapController.animateCamera(cameraUpdate);
  }

  zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  get hasStartedRoute {
    return _hasStartedRoute;
  }
}
