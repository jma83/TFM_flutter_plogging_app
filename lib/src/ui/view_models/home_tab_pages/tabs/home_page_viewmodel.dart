import 'package:flutter_plogging/src/core/application/get_followers_route_list.dart';
import 'package:flutter_plogging/src/core/application/get_users_by_ids.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends HomeTabsChangeNotifier {
  List<RouteListAuthorData> _routesWithAuthor = [];
  late int _selectedRouteIndex;
  final GetFollowersRouteList _getFollowersRouteList;
  final ManageLikeRoute _manageLikeRoute;
  final LoadingService _loadingService;
  final GetUsersByIds _getUsersByIds;
  HomePageViewModel(authenticationService, this._getFollowersRouteList,
      this._manageLikeRoute, this._loadingService, this._getUsersByIds)
      : super(authenticationService);

  @override
  Future<void> loadPage() async {
    _routesWithAuthor.clear();
    toggleLoading(loading: true);
    final List<RouteListData> routes =
        await _getFollowersRouteList.execute(currentUserId);
    if (routes.isEmpty) return updateAndToggle();
    final List<UserData> users =
        await _getUsersByIds.execute(routes.map((e) => e.userId!).toList());
    if (users.isEmpty) return updateAndToggle();
    _routesWithAuthor = RouteListAuthorData.convertRoutes(routes, users);
    updateAndToggle();
  }

  updateAndToggle() {
    toggleLoading(loading: false);
    updatePage();
  }

  likeRoute(RouteListData routeData) async {
    _manageLikeRoute.execute(routeData, updatePage);
  }

  navigateToRoute(RouteListData route) {
    setSelectedRoute(route);
    notifyListeners(HomeNotifiers.navigateToRoute);
  }

  @override
  updatePage() {
    notifyListeners(HomeNotifiers.updateHomePage);
  }

  @override
  updateData(RouteListAuthorSearchData data) {
    for (int i = 0; i < _routesWithAuthor.length; i++) {
      if (_routesWithAuthor[i].routeListData.id != data.routeListData?.id) {
        continue;
      }
      if (data.routeListData != null) {
        _routesWithAuthor[i].routeListData = data.routeListData!;
      }
      if (data.userData != null) {
        _routesWithAuthor[i].userData = data.userData!;
      }
      break;
    }
    updatePage();
  }

  toggleLoading({bool loading = false}) {
    _loadingService.setLoading(loading);
  }

  setSelectedRoute(RouteListData route) {
    _selectedRouteIndex = _routesWithAuthor
        .indexWhere((element) => element.routeListData.id == route.id);
  }

  RouteListData? get selectedRoute {
    final isInvalid = _selectedRouteIndex == -1 ||
        _selectedRouteIndex >= _routesWithAuthor.length;
    return isInvalid
        ? null
        : _routesWithAuthor[_selectedRouteIndex].routeListData;
  }

  UserSearchData? get selectedAuthor {
    final isInvalid = _selectedRouteIndex == -1 ||
        _selectedRouteIndex >= _routesWithAuthor.length;
    return isInvalid ? null : _routesWithAuthor[_selectedRouteIndex].userData;
  }

  List<RouteListAuthorData> get routesWithAuthor {
    return _routesWithAuthor;
  }

  String get username {
    return currentUser.username;
  }
}
