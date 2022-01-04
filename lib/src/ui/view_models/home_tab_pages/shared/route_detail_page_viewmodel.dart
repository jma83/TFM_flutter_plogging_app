import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/application/calculate_points_distance.dart';
import 'package:flutter_plogging/src/core/application/generate_new_polyline.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_id.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class RouteDetailPageViewModel extends HomeTabsChangeNotifier {
  late RouteListData _routeListData;
  late UserSearchData _userData;
  late GoogleMapController mapController;

  final GenerateNewPolyline _generateNewPolyline;
  final ManageLikeRoute _manageLikeRoute;
  final CalculatePointsDistance _calculatePointsDistance;
  final GetRouteListById _getRouteListById;
  final GetUserById _getUserById;
  final LoadingService _loadingService;

  final String _instanceId;
  Map<PolylineId, Polyline> polylines = {};

  RouteDetailPageViewModel(
      AuthenticationService authenticationService,
      this._manageLikeRoute,
      this._calculatePointsDistance,
      this._generateNewPolyline,
      this._instanceId,
      this._getRouteListById,
      this._getUserById,
      this._loadingService)
      : super(authenticationService);

  void setRouteAndAuthor(RouteListData route, UserData user) {
    _routeListData = route;
    _userData = UserSearchData(user: user);
  }

  @override
  loadPage() async {
    _loadingService.toggleLoading();
    await _getRouteListById.execute(_routeListData.id!);
    await _getUserById.execute(_userData.id);
    updatePage();
    _loadingService.toggleLoading();
  }

  @override
  updateData(RouteListAuthorSearchData data) {
    if (data.routeListData != null) {
      _routeListData = data.routeListData!;
    }
    if (data.userData != null) {
      _userData = data.userData!;
    }
    updatePage();
  }

  manageLikeRoute() {
    _manageLikeRoute.execute(_routeListData, updatePage);
    notifyListeners(RouteDetailNotifier.updateData);
  }

  @override
  updatePage() {
    notifyListeners(RouteDetailNotifier.updatePage);
  }

  setMapController(GoogleMapController gmapController) {
    mapController = gmapController;
  }

  loadPolylines() {
    generatePolylines();
    updatePage();
  }

  void generatePolylines() {
    Polyline? polyline = _generateNewPolyline.executeNew(
        GeoPointUtils.convertGeopointsToLatLng(route.locationArray),
        Colors.red);
    polylines[polyline.polylineId] = polyline;
  }

  void setCameraPosition() {
    if (route.locationArray.isEmpty) return;
    double accLat = 0;
    double accLong = 0;
    double latitudeMedian = 0;
    double longitudeMedian = 0;
    double distance = 0;
    double zoom = 0;
    for (int i = 0; i < route.locationArray.length; i++) {
      accLat += route.locationArray[i].latitude;
      accLong += route.locationArray[i].longitude;
      if (i != route.locationArray.length - 1) {
        continue;
      }
      latitudeMedian = accLat / route.locationArray.length;
      longitudeMedian = accLong / route.locationArray.length;
      List<LatLng> latLngList = [];
      latLngList
          .add(GeoPointUtils.convertGeopointToLatLng(route.locationArray[0]));
      latLngList.add(GeoPointUtils.convertGeopointToLatLng(
          route.locationArray[route.locationArray.length - 1]));
      distance = _calculatePointsDistance.execute(latLngList);
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

    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latitudeMedian, longitudeMedian),
        zoom: zoom <= 8 ? 8 : zoom));

    animateCamera(cameraUpdate);
  }

  animateCamera(CameraUpdate cameraUpdate) {
    mapController.animateCamera(cameraUpdate);
  }

  String getRouteDateWithFormat() {
    return DateCustomUtils.dateTimeToStringFormat(
        _routeListData.endDate!.toDate());
  }

  void navigateToAuthor() {
    notifyListeners(RouteDetailNotifier.navigateToAuthor);
  }

  void navigateToPrevious() {
    notifyListeners(RouteDetailNotifier.navigateToPrevious);
  }

  double truncateDistance() {
    return double.parse((route.distance!).toStringAsFixed(2));
  }

  RouteListData get route {
    return _routeListData;
  }

  UserSearchData get author {
    return _userData;
  }

  String get instanceId {
    return _instanceId;
  }
}
