import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/application/search_route_list.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/ui/notifiers/my_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyRoutesPageViewModel extends HomeTabsChangeNotifier {
  List<RouteListData> _routes = [];
  String _searchValue = "";
  bool _isLoading = false;
  late RouteListData _selectedRoute;
  final GetRouteListByUser _getRouteListByUser;
  final SearchRouteList _searchRouteList;
  final ManageLikeRoute _manageLikeRoute;
  MyRoutesPageViewModel(authService, this._manageLikeRoute,
      this._getRouteListByUser, this._searchRouteList)
      : super(authService);

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value, bool isFirst) async {
    toggleLoading(!isFirst);
    if (value.isEmpty) {
      _routes = await _getRouteListByUser.execute(currentUserId);
    } else {
      _routes = await _searchRouteList.execute(value, currentUserId);
    }
    toggleLoading(!isFirst);
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

  updatePage() {
    notifyListeners("update_my_routes");
  }

  toggleLoading(bool isVisible) {
    if (isVisible) {
      _isLoading
          ? EasyLoading.dismiss()
          : EasyLoading.show(status: 'loading...');
    }
    _isLoading = !_isLoading;
  }

  likeRoute(RouteListData routeData) async {
    _manageLikeRoute.execute(routeData, updatePage);
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
