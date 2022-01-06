import 'package:flutter_plogging/src/core/application/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/search_route_list.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/my_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyRoutesPageViewModel extends HomeTabsChangeNotifier {
  List<RouteListAuthorData> _routes = [];
  String _searchValue = "";
  late RouteListData _selectedRoute;
  final GetRouteListByUser _getRouteListByUser;
  final SearchRouteList _searchRouteList;
  final ManageLikeRoute _manageLikeRoute;
  final LoadingService _loadingService;

  MyRoutesPageViewModel(authService, this._manageLikeRoute,
      this._getRouteListByUser, this._searchRouteList, this._loadingService)
      : super(authService);

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value) async {
    toggleLoading();
    List<RouteListData> routes = [];
    if (value.isEmpty) {
      routes = await _getRouteListByUser.execute(currentUserId);
    } else {
      routes = await _searchRouteList.execute(value, currentUserId);
    }
    _routes = RouteListAuthorData.convertRoutesUniqueUser(routes, currentUser);
    toggleLoading();
    updatePage();
  }

  navigateToRoute(RouteListData route) {
    setSelectedRoute(route);
    notifyListeners(MyRouteNotifiers.navigateToRoute);
  }

  setSelectedRoute(RouteListData route) {
    _selectedRoute = route;
  }

  RouteListData get selectedRoute {
    return _selectedRoute;
  }

  UserSearchData get selectedAuthor {
    return UserSearchData(user: currentUser);
  }

  @override
  updatePage() {
    notifyListeners(MyRouteNotifiers.updateMyRoutesPage);
  }

  @override
  updateData(RouteListAuthorSearchData data) {
    for (int i = 0; i < _routes.length; i++) {
      if (_routes[i].routeListData.id != data.routeListData?.id) {
        continue;
      }
      if (data.routeListData != null) {
        _routes[i].routeListData = data.routeListData!;
      }
      if (data.userData != null) {
        _routes[i].userData = data.userData!;
      }
      break;
    }
    updatePage();
  }

  toggleLoading() {
    _loadingService.toggleLoading();
  }

  likeRoute(RouteListData routeData) async {
    _manageLikeRoute.execute(routeData, updatePage);
  }

  String get searchValue {
    return _searchValue;
  }

  List<RouteListAuthorData> get routes {
    return _routes;
  }
}
