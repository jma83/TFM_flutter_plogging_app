// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/application/user/get_top_level_users.dart';
import 'package:flutter_plogging/src/core/application/follower/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/follower/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/user/search_user_list.dart';
import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/search_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageViewModel extends HomeTabsChangeNotifier {
  String _searchValue = "";
  bool _isTop = true;
  late UserSearchData _userSelected;
  List<UserSearchData> _users = [];
  List<FollowerData> _followingList = [];
  final ManageFollowUser _manageFollowUser;
  final GetUserFollowing _getUserFollowing;
  final SearchUserList _searchUserList;
  final LoadingService _loadingService;
  final GetTopLevelUsers _getTopLevelUsers;

  SearchPageViewModel(
      authenticationService,
      this._manageFollowUser,
      this._getUserFollowing,
      this._searchUserList,
      this._loadingService,
      this._getTopLevelUsers)
      : super(authenticationService);

  @override
  loadPage() async {
    toggleLoading(loading: true);
    await _updateFollowingUsers();
    final List<UserData> usersFound = await _getTopLevelUsers.execute();
    _users = UserSearchData.createListFromUsersAndFollows(
        usersFound, _followingList);
    updatePage();
    toggleLoading(loading: false);
  }

  setSearchValue(String value) {
    _searchValue = value;
  }

  setSearchUser(UserSearchData user) {
    _userSelected = user;
  }

  Future<void> submitSearch(String value, bool isFirst) async {
    _isTop = false;
    toggleLoading(loading: true);
    final List<UserData> usersFound = await _searchUserList.execute(value);
    _users = UserSearchData.createListFromUsersAndFollows(
        usersFound, _followingList);
    toggleLoading(loading: false);
    updatePage();
    //_updateFollowingUsers();
  }

  _updateFollowingUsers() async {
    _followingList = await _getUserFollowing.execute(currentUserId);
  }

  @override
  updatePage() {
    notifyListeners(SearchNotifiers.updateSearchPage);
  }

  @override
  updateData(RouteListAuthorSearchData data) {
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].id != data.userData?.id) {
        continue;
      }
      if (data.userData != null) {
        _users[i] = data.userData!;
      }
      break;
    }
    updatePage();
  }

  toggleLoading({bool loading = false}) {
    _loadingService.setLoading(loading);
  }

  handleFollowUser(UserSearchData userData) async {
    await _manageFollowUser.execute(userData, currentUserFromList, updatePage);
  }

  UserSearchData get currentUserFromList {
    UserSearchData? user =
        _users.firstWhereOrNull((element) => element.id == currentUserId);
    user = UserSearchData(
        user: currentUser, followerId: null, followingFlag: false);

    return user;
  }

  navigateToUser(UserSearchData user) {
    setSearchUser(user);
    notifyListeners(SearchNotifiers.navigateToAuthor);
  }

  String get searchValue {
    return _searchValue;
  }

  UserSearchData get selectedUser {
    return _userSelected;
  }

  List<UserSearchData> get users {
    return _users;
  }

  String get title {
    return _isTop ? "Featured users:" : "Search results: ";
  }
}
