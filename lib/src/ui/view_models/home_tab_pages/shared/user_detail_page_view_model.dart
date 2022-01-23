import 'package:flutter_plogging/src/core/application/follower/check_user_followed.dart';
import 'package:flutter_plogging/src/core/application/route/get_route_list_by_user.dart';
import 'package:flutter_plogging/src/core/application/follower/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/like/manage_like_route.dart';
import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/gender/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';

class UserDetailPageViewModel extends HomeTabsChangeNotifier {
  late UserSearchData _userData;
  RouteListData? _routeListData;
  List<RouteListData> _userRoutes = [];
  final GetRouteListByUser _getRouteListByUser;
  final ManageLikeRoute _manageLikeRoute;
  final ManageFollowUser _manageFollowUser;
  final CheckUserFollowed _checkUserFollowed;
  final LoadingService _loadingService;
  UserDetailPageViewModel(
      authService,
      this._getRouteListByUser,
      this._manageLikeRoute,
      this._manageFollowUser,
      this._checkUserFollowed,
      this._loadingService)
      : super(authService);

  String getDateFormat(RouteListData route) {
    return DateCustomUtils.dateTimeToStringFormat(route.endDate!.toDate());
  }

  @override
  updatePage() {
    notifyListeners(UserDetailNotifier.updatePage);
  }

  @override
  loadPage() async {
    _loadingService.toggleLoading();
    await checkUserFollow();
    updatePage();
    await getUserRoutes();
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

  setUserData(UserSearchData user) async {
    _userData = user;
  }

  setSelectedRoute(RouteListData route) {
    _routeListData = route;
  }

  checkUserFollow() async {
    final FollowerData? follower = await _checkUserFollowed.execute(user.id);
    _userData.followerId = follower?.id;
    _userData.followingFlag = follower != null;
  }

  getUserRoutes() async {
    _userRoutes = await _getRouteListByUser.execute(user.id);
  }

  likeRoute(RouteListData routeData) async {
    _manageLikeRoute.execute(routeData, updatePage);
    setSelectedRoute(routeData);
    notifyListeners(UserDetailNotifier.updateData);
    updatePage();
  }

  followUser() {
    _manageFollowUser.execute(
        _userData, UserSearchData(user: currentUser), updatePage);
    notifyListeners(UserDetailNotifier.updateData);
    updatePage();
  }

  navigateToRoute(RouteListData route) {
    setSelectedRoute(route);
    notifyListeners(UserDetailNotifier.navigateToRoute);
  }

  void navigateToPrevious() {
    notifyListeners(UserDetailNotifier.navigateToPrevious);
  }

  get formattedCreationDate {
    return DateCustomUtils.dateTimeToStringFormat(user.creationDate.toDate(),
        onlyDate: true);
  }

  get formattedGender {
    return Gender.getGenderFromIndex(user.gender);
  }

  UserSearchData get user {
    return _userData;
  }

  RouteListData? get selectedRoute {
    return _routeListData;
  }

  List<RouteListData> get userRoutes {
    return _userRoutes;
  }
}
