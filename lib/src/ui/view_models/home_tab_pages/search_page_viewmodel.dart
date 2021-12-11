import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/user_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPageViewModel extends HomeTabsChangeNotifier {
  String _searchValue = "";
  bool _isLoading = false;
  List<UserSearchData> _users = [];
  List<FollowerData> _followingList = [];
  final UuidGeneratorService _uuidGeneratorService;
  final FollowerModel _followerModel;
  final UserModel _userModel;

  SearchPageViewModel(authenticationService, this._userModel,
      this._followerModel, this._uuidGeneratorService)
      : super(authenticationService);

  loadPage() async {
    _followingList = await _followerModel.queryElementEqualByCriteria(
        FollowerFieldData.userId, authenticationService.currentUser!.uid);
  }

  setSearchValue(String value) {
    _searchValue = value;
  }

  Future<void> submitSearch(String value) async {
    toggleLoading();
    final List<UserData> usersFound = await _userModel
        .queryElementLikeByCriteria(UserFieldData.username, value);
    final followingIds = _followingList.map((e) => e.userFollowedId);
    _users = usersFound
        .map((user) => UserSearchData(
            user: user, followingFlag: followingIds.contains(user.id)))
        .toList();

    toggleLoading();
    notifyListeners("update_search_page");
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
  }

  handleFollowUser(UserSearchData userData) async {
    FollowerData? follower;
    for (int i = 0; i < _followingList.length; i++) {
      if (_followingList[i].userFollowedId == userData.id) {
        follower = _followingList[i];
        break;
      }
    }
    userData.followingFlag = !userData.followingFlag;
    if (follower != null) {
      await removeElement(userData, follower);
      return;
    }
    final FollowerData newFollowerData = FollowerData(
        id: _uuidGeneratorService.generate(),
        userId: authenticationService.currentUser!.uid,
        userFollowedId: userData.id);
    await addElement(userData, newFollowerData);
  }

  removeElement(
      UserSearchData userSearchData, FollowerData followerData) async {
    _followerModel.removeElement(followerData.id);
    _followingList.remove(followerData);
    await updateFollowCount(userSearchData, false);
    notifyListeners("update_search_page");
  }

  addElement(UserSearchData userSearchData, FollowerData followerData) async {
    _followingList.add(followerData);
    _followerModel.addElement(followerData);
    await updateFollowCount(userSearchData, true);
  }

  updateFollowCount(UserSearchData userData, bool add) async {
    updateFollowers(userData, add);
    updateFollowing(add);
    notifyListeners("update_search_page");
    await updateUser(userData);
    await updateUser(currentUser);
  }

  updateFollowers(UserSearchData userData, bool add) {
    userData.followers += add ? 1 : -1;
    userData.followingFlag = add;
  }

  updateFollowing(bool add) {
    _users.forEach((element) {
      if (element.id == currentUser.id) {
        element.following = currentUser.following;
        element.followingFlag = add;
        return;
      }
    });
  }

  Future<void> updateUser(UserData userData) async {
    await _userModel.updateElement(userData.id, userData);
  }

  get searchValue {
    return _searchValue;
  }

  List<UserSearchData> get users {
    return _users;
  }
}
