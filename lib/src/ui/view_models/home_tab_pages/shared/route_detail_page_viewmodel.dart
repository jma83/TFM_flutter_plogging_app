import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/application/route/calculate_route_camera_position.dart';
import 'package:flutter_plogging/src/core/application/route/generate_new_polyline.dart';
import 'package:flutter_plogging/src/core/application/route/get_route_list_by_id.dart';
import 'package:flutter_plogging/src/core/application/like/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:flutter_plogging/src/utils/distance_utils.dart';
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
  final CalculateRouteCameraPosition _calculateRouteCameraPosition;
  final GetRouteListById _getRouteListById;
  final GetUserById _getUserById;
  final LoadingService _loadingService;

  final String _instanceId;
  List<Polyline> polylines = [];

  RouteDetailPageViewModel(
      AuthenticationService authenticationService,
      this._manageLikeRoute,
      this._calculateRouteCameraPosition,
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
    toggleLoading(loading: true);
    await _getRouteListById.execute(_routeListData.id!);
    await _getUserById.execute(_userData.id);
    updatePage();
    toggleLoading(loading: false);
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

  toggleLoading({bool loading = false}) {
    _loadingService.setLoading(loading);
  }

  void generatePolylines() {
    Polyline polyline = _generateNewPolyline.executeNew(
        GeoPointUtils.convertGeopointsToLatLng(route.locationArray),
        Colors.red);
    polylines.add(polyline);
  }

  void setCameraPosition() async {
    if (route.locationArray.isEmpty) return;
    CameraUpdate cameraUpdate = _calculateRouteCameraPosition.execute(route);
    await animateCamera(cameraUpdate);
  }

  zoomOut() {
    animateCamera(CameraUpdate.zoomOut());
  }

  zoomIn() {
    animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> animateCamera(CameraUpdate cameraUpdate) async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      mapController.animateCamera(cameraUpdate);
    });
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

  double get distance {
    return DistanceUtils.getDistanceFormat(route.distance);
  }

  String get meassure {
    return DistanceUtils.getMeassure(route.distance);
  }

  String get duration {
    return DateCustomUtils.formattedDurationBySeconds(route.duration);
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
