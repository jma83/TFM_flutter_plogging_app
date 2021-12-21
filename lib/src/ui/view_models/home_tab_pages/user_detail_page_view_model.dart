import 'package:flutter_plogging/src/core/application/check_user_followed.dart';
import 'package:flutter_plogging/src/core/application/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/ui/notifiers/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class UserDetailPageViewModel extends HomeTabsChangeNotifier {
  late UserSearchData _userData;
  late RouteListData _routeListData;
  List<RouteListData> _userRoutes = [];
  final GetRouteListByUser _getRouteListByUser;
  final ManageLikeRoute _manageLikeRoute;
  final ManageFollowUser _manageFollowUser;
  final CheckUserFollowed _checkUserFollowed;
  UserDetailPageViewModel(authService, this._getRouteListByUser,
      this._manageLikeRoute, this._manageFollowUser, this._checkUserFollowed)
      : super(authService);

  String getDateFormat(RouteListData route) {
    return DateCustomUtils.dateTimeToStringFormat(route.endDate!.toDate());
  }

  loadPage() async {
    final FollowerData? follower = await _checkUserFollowed.execute(user.id);
    setUserData(_userData, follower: follower);
    await getUserRoutes();
    notifyListeners(UserDetailNotifier.updatePage);
  }

  setUserData(UserData user, {FollowerData? follower}) async {
    _userData = UserSearchData(
        user: user, followerId: follower?.id, followingFlag: follower != null);
  }

  setSelectedRoute(RouteListData route) {
    _routeListData = route;
  }

  getUserRoutes() async {
    _userRoutes = await _getRouteListByUser.execute(user.id);
  }

  likeRoute(RouteListData routeData) async {
    _manageLikeRoute.execute(routeData, updatePage);
  }

  followUser() {
    _manageFollowUser.execute(
        _userData, UserSearchData(user: currentUser), updatePage);
  }

  navigateToRoute(RouteListData route) {
    setSelectedRoute(route);
    notifyListeners(UserDetailNotifier.navigateToRoute);
  }

  get formattedCreationDate {
    return DateCustomUtils.dateTimeToStringFormat(user.creationDate.toDate(),
        onlyDate: true);
  }

  get formattedGender {
    return Gender.getGenderFromIndex(user.gender);
  }

  UserData get user {
    return _userData;
  }

  RouteListData get selectedRoute {
    return _routeListData;
  }

  List<RouteListData> get userRoutes {
    return _userRoutes;
  }
}
