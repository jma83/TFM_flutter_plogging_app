import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/application/get_user_following.dart';
import 'package:flutter_plogging/src/core/application/manage_follow_user.dart';
import 'package:flutter_plogging/src/core/application/search_user_list.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/search_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageViewModel extends HomeTabsChangeNotifier {
  String _searchValue = "";
  late UserData _userSelected;
  List<UserSearchData> _users = [];
  List<FollowerData> _followingList = [];
  final ManageFollowUser _manageFollowUser;
  final GetUserFollowing _getUserFollowing;
  final SearchUserList _searchUserList;
  final LoadingService _loadingService;

  SearchPageViewModel(authenticationService, this._manageFollowUser,
      this._getUserFollowing, this._searchUserList, this._loadingService)
      : super(authenticationService);

  @override
  loadPage() async {
    _updateFollowingUsers();
  }

  setSearchValue(String value) {
    _searchValue = value;
  }

  setSearchUser(UserData user) {
    _userSelected = user;
  }

  Future<void> submitSearch(String value, bool isFirst) async {
    toggleLoading();
    final List<UserData> usersFound = await _searchUserList.execute(value);
    _users = UserSearchData.createListFromUsersAndFollows(
        usersFound, _followingList);
    toggleLoading();
    updatePage();
    _updateFollowingUsers();
  }

  _updateFollowingUsers() async {
    _followingList = await _getUserFollowing.execute(currentUserId);
  }

  @override
  updatePage() {
    notifyListeners("update_search_page");
  }

  toggleLoading() {
    _loadingService.toggleLoading();
  }

  handleFollowUser(UserSearchData userData) async {
    await _manageFollowUser.execute(userData, currentUserFromList, updatePage);
  }

  UserSearchData get currentUserFromList {
    UserSearchData? user =
        _users.firstWhereOrNull((element) => element.id == currentUserId);
    user ??= UserSearchData(
        user: currentUser, followerId: null, followingFlag: false);

    return user;
  }

  navigateToUser(UserSearchData user) {
    setSearchUser(user);
    notifyListeners(SearchNotifiers.navigateToAuthor);
  }

  get searchValue {
    return _searchValue;
  }

  get selectedUser {
    return _userSelected;
  }

  List<UserSearchData> get users {
    return _users;
  }
}
