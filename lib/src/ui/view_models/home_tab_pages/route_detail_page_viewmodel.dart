import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/application/calculate_points_distance.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class RouteDetailPageViewModel extends HomeTabsChangeNotifier {
  late RouteListData _routeListData;
  late UserData _userData;
  late GoogleMapController mapController;

  final ManageLikeRoute _manageLikeRoute;
  final CalculatePointsDistance _calculatePointsDistance;
  RouteDetailPageViewModel(AuthenticationService authenticationService,
      this._manageLikeRoute, this._calculatePointsDistance)
      : super(authenticationService);

  Future<void> setRouteAndAuthor(RouteListData route, UserData user) async {
    _routeListData = route;
    _userData = user;
  }

  manageLikeRoute() {
    _manageLikeRoute.execute(_routeListData, updatePage);
  }

  @override
  updatePage() {
    notifyListeners(RouteDetailNotifier.updatePage);
    notifyListeners(HomeNotifiers.updateHomePage);
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  CameraPosition setCameraPosition() {
    if (route.locationArray.length <= 0) {
      return CameraPosition(target: LatLng(0, 0), zoom: 8);
    }
    double accLat = 0;
    double accLong = 0;
    double latitudeMedian = 0;
    double longitudeMedian = 0;
    double distance = 0;
    double zoom = 0;
    for (int i = 0; i < route.locationArray.length; i++) {
      accLat += route.locationArray[i].latitude;
      accLong += route.locationArray[i].longitude;
      if (i == route.locationArray.length - 1) {
        latitudeMedian = accLat / route.locationArray.length;
        longitudeMedian = accLong / route.locationArray.length;
        List<LatLng> latLngList = [];
        latLngList
            .add(GeoPointUtils.convertGeopointToLatLng(route.locationArray[0]));
        latLngList.add(GeoPointUtils.convertGeopointToLatLng(
            route.locationArray[route.locationArray.length - 1]));
        distance = _calculatePointsDistance.execute(latLngList);
      }
    }

    if (distance < 500) {
      zoom = 20;
    }

    if (distance >= 500 && distance < 1000) {
      zoom = 18;
    }

    if (distance >= 1000 && distance < 3000) {
      zoom = 17;
    }

    if (distance >= 3000) {
      zoom = 15;
    }

    return CameraPosition(
        target: LatLng(latitudeMedian, longitudeMedian),
        zoom: zoom <= 8 ? 8 : zoom);
  }

  String getRouteDateWithFormat() {
    return DateCustomUtils.dateTimeToStringFormat(
        _routeListData.endDate!.toDate());
  }

  RouteListData get route {
    return _routeListData;
  }

  UserData get author {
    return _userData;
  }
}
