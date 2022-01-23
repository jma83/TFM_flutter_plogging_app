// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/application/like/get_liked_routes_list.dart';
import 'package:flutter_plogging/src/core/application/like/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/user/get_users_by_ids.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/liked_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class LikedRoutesPageViewModel extends HomeTabsChangeNotifier {
  List<RouteListAuthorData> _routesWithAuthor = [];
  late RouteListData _selectedRoute;
  late UserSearchData _selectedUser;
  final GetLikedRoutesList _getLikedRoutesList;
  final ManageLikeRoute _manageLikeRoute;
  final LoadingService _loadingService;
  final GetUsersByIds _getUsersByIds;

  LikedRoutesPageViewModel(
      AuthenticationService authService,
      this._manageLikeRoute,
      this._getLikedRoutesList,
      this._getUsersByIds,
      this._loadingService)
      : super(authService);

  @override
  Future<void> loadPage() async {
    _routesWithAuthor.clear();
    toggleLoading(loading: true);
    final List<RouteListData> routes =
        await _getLikedRoutesList.execute(currentUserId);
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

  navigateToRoute(RouteListData route) {
    final data = _routesWithAuthor
        .firstWhereOrNull((e) => e.routeListData.id == route.id);

    setSelectedRoute(data!.routeListData);
    setSelectedUser(data.userData);
    notifyListeners(LikedRoutesNotifiers.navigateToRoute);
  }

  navigateToPrevious() {
    notifyListeners(LikedRoutesNotifiers.returnToPrevious);
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

  setSelectedRoute(RouteListData route) {
    _selectedRoute = route;
  }

  setSelectedUser(UserSearchData user) {
    _selectedUser = user;
  }

  RouteListData get selectedRoute {
    return _selectedRoute;
  }

  UserSearchData get selectedUser {
    return _selectedUser;
  }

  @override
  updatePage() {
    notifyListeners(LikedRoutesNotifiers.updateLikedRoutesPage);
  }

  toggleLoading({bool loading = false}) {
    _loadingService.setLoading(loading);
  }

  likeRoute(RouteListData routeData) async {
    _manageLikeRoute.execute(routeData, updatePage);
  }

  List<RouteListAuthorData> get routes {
    return _routesWithAuthor;
  }
}
