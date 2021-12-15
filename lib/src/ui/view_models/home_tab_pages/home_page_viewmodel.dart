import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/application/get_followers_route_list.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomePageViewModel extends HomeTabsChangeNotifier {
  List<RouteListData> _routes = [];
  late RouteListData _selectedRoute;
  final GetFollowersRouteList _getFollowersRouteList;
  final ManageLikeRoute _manageLikeRoute;
  final LoadingService _loadingService;
  HomePageViewModel(authenticationService, this._getFollowersRouteList,
      this._manageLikeRoute, this._loadingService)
      : super(authenticationService);

  Future<void> loadPage() async {
    toggleLoading();
    _routes = await _getFollowersRouteList.execute(currentUserId);
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

  updatePage() {
    notifyListeners(HomeNotifiers.updateHomePage);
  }

  toggleLoading() {
    _loadingService.toggleLoading();
  }

  setSelectedRoute(RouteListData route) {
    _selectedRoute = route;
  }

  RouteListData get selectedRoute {
    return _selectedRoute;
  }

  List<RouteListData> get routes {
    return _routes;
  }

  String get username {
    return currentUser.username;
  }

  String getDateFormat(RouteListData route) {
    return DateCustomUtils.dateTimeToStringFormat(route.endDate!.toDate());
  }
}
