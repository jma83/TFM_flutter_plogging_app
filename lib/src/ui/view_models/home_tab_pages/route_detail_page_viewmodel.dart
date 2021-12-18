import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class RouteDetailPageViewModel extends HomeTabsChangeNotifier {
  late RouteListData _routeListData;
  late UserData _userData;
  late GoogleMapController mapController;

  final ManageLikeRoute _manageLikeRoute;
  RouteDetailPageViewModel(
      AuthenticationService authenticationService, this._manageLikeRoute)
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

  CameraPosition getCameraPosition() {
    GeoPoint geoPoint = route.locationArray.reduce((value, element) => GeoPoint(
        value.latitude + element.latitude,
        value.longitude + element.longitude));
    final latitudeMedian = geoPoint.latitude / route.locationArray.length;
    final longitudeMedian = geoPoint.longitude / route.locationArray.length;
    return CameraPosition(
        target: LatLng(latitudeMedian, longitudeMedian), zoom: 8);
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
