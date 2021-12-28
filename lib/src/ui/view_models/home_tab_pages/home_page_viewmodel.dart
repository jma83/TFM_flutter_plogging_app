import 'package:flutter_plogging/src/core/application/get_followers_route_list.dart';
import 'package:flutter_plogging/src/core/application/get_users_by_ids.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
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
    toggleLoading();
    final List<RouteListData> routes =
        await _getFollowersRouteList.execute(currentUserId);
    if (routes.isEmpty) return updateAndToggle();
    final List<UserData> users =
        await _getUsersByIds.execute(routes.map((e) => e.userId!).toList());
    if (users.isEmpty) return updateAndToggle();
    for (int i = 0; i < routes.length; i++) {
      _routesWithAuthor = [
        ..._routesWithAuthor,
        RouteListAuthorData(routes[i], users[i])
      ];
    }
    updateAndToggle();
  }

  updateAndToggle() {
    toggleLoading();
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
    notifyListeners(HomeNotifiers.updateHomePage);

    /*_routesWithAuthor.forEach((element) {
      if (element.routeListData.id == data.routeListData!.id) {
        element.routeListData = data.routeListData!;
        return;
      }
    }); */
  }

  toggleLoading() {
    _loadingService.toggleLoading();
  }

  setSelectedRoute(RouteListData route) {
    _selectedRouteIndex = _routesWithAuthor
        .indexWhere((element) => element.routeListData.id == route.id);
  }

  RouteListData get selectedRoute {
    return _routesWithAuthor[_selectedRouteIndex].routeListData;
  }

  UserData get selectedAuthor {
    return _routesWithAuthor[_selectedRouteIndex].userData;
  }

  List<RouteListData> get routes {
    return _routesWithAuthor.map((e) => e.routeListData).toList();
  }

  String get username {
    return currentUser.username;
  }

  String getDateFormat(RouteListData route) {
    return DateCustomUtils.dateTimeToStringFormat(route.endDate!.toDate());
  }
}
