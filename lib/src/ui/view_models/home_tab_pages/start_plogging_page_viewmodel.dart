import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@injectable
class StartPloggingPageViewModel extends HomeTabsChangeNotifier {
  RouteStoreService _routeStoreService;
  UiidGeneratorService _uiidGeneratorService;
  late GoogleMapController mapController;
  late Position currentPosition;

  StartPloggingPageViewModel(AuthenticationService authenticationService,
      this._routeStoreService, this._uiidGeneratorService)
      : super(authenticationService) {
    getCurrentLocation();
  }

  bool _hasStartedRoute = false;

  beginRoute() {
    _hasStartedRoute = true;
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

  getCurrentLocation() async {
    print("CURRENT!");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // Store the position in the variable
      currentPosition = position;

      print('CURRENT POS: $currentPosition');

      // For moving the camera to current location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
      // await _getAddress();
    }).catchError((e) {
      print("error getting location");
      print(e);
    });
  }

  get hasStartedRoute {
    return _hasStartedRoute;
  }
}
