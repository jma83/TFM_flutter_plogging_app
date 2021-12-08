import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/domain/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/services/like_store_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class MyRoutesPageViewModel extends HomeTabsChangeNotifier {
  List<RouteListData> _routes = [];
  List<LikeData> _likes = [];
  String _searchValue = "";
  bool _isLoading = false;
  final RouteStoreService _routeStoreService;
  final LikeStoreService _likeStoreService;
  final UuidGeneratorService _uuidGeneratorService;
  MyRoutesPageViewModel(authService, this._routeStoreService,
      this._likeStoreService, this._uuidGeneratorService)
      : super(authService);

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value) async {
    toggleLoading();
    List<RouteData> routes = [];
    if (value.isEmpty) {
      routes = await emptyTextSearch();
    } else {
      routes = await textSearch(value);
    }
    matchRoutesWithLikes(routes);
    toggleAndUpdate();
  }

  Future<List<RouteData>> emptyTextSearch() async {
    final userId = authenticationService.currentUser!.uid;

    List<RouteData> routes = await _routeStoreService
        .queryElementEqualByCriteria(RouteFieldData.userId, userId);
    _likes = await _likeStoreService.queryElementEqualByCriteria(
        LikeFieldData.userId, authenticationService.currentUser!.uid);
    return routes;
  }

  Future<List<RouteData>> textSearch(String value) async {
    final userId = authenticationService.currentUser!.uid;

    List<RouteData> routes =
        await _routeStoreService.searchRoutesByNameAndAuthor(value, userId);
    if (routes.isEmpty) {
      toggleAndUpdate();
      return [];
    }
    _likes = await _likeStoreService.matchRoutesWithUserLikes(
        userId, routes.map((e) => e.id!).toList());
    return routes;
  }

  matchRoutesWithLikes(List<RouteData> routes) {
    final likedRouteIds = _likes.map((e) => e.routeId).toList();
    _routes = routes
        .map((RouteData route) => RouteListData(
            routeData: route, isLiked: likedRouteIds.contains(route.id)))
        .toList();
  }

  toggleAndUpdate() {
    toggleLoading();
    updatePage();
  }

  updatePage() {
    notifyListeners("update_my_routes");
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
  }

  likeRoute(RouteListData routeData) async {
    LikeData? like;

    routeData.isLiked = !routeData.isLiked;
    updatePage();

    _likes.forEach((element) {
      if (element.routeId == routeData.id) {
        like = element;
        return;
      }
    });

    like != null ? removeLikeFromRoute(like!) : addLikeToRoute(routeData);
  }

  removeLikeFromRoute(LikeData like) async {
    _likes.remove(like);
    await _likeStoreService.removeElement(like.id);
  }

  addLikeToRoute(RouteListData routeData) async {
    final newLike = LikeData(
        userId: currenUserId,
        routeId: routeData.id!,
        id: _uuidGeneratorService.generate());
    _likes.add(newLike);
    await _likeStoreService.addElement(newLike);
  }

  String get searchValue {
    return _searchValue;
  }

  List<RouteListData> get routes {
    return _routes;
  }

  String getDateFormat(RouteListData route) {
    return DateCustomUtils.dateTimeToStringFormat(route.endDate!.toDate());
  }
}
