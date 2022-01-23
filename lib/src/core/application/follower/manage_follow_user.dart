import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';

@injectable
class ManageFollowUser {
  final UuidGeneratorService _uuidGeneratorService;
  final FollowerModel _followerModel;
  final UserModel _userModel;

  ManageFollowUser(
      this._uuidGeneratorService, this._followerModel, this._userModel);

  Future<void> execute(UserSearchData userData, UserSearchData currentUserData,
      Function updatePageCallback) async {
    userData.followingFlag = !userData.followingFlag;
    updateFollowCount(userData, currentUserData, userData.followingFlag);
    updatePageCallback();
    if (!userData.followingFlag) {
      await _removeElement(userData, currentUserData);
    } else {
      await _addElement(userData, currentUserData);
    }
  }

  _removeElement(
      UserSearchData userSearchData, UserSearchData currentUserData) async {
    final String followerId = userSearchData.followerId!;
    userSearchData.followerId = null;
    await _followerModel.removeElement(followerId);
    await updateUserFollowData(userSearchData, currentUserData, false);
  }

  _addElement(
      UserSearchData userSearchData, UserSearchData currentUserData) async {
    final String followerId = _uuidGeneratorService.generate();
    final FollowerData followerData = FollowerData(
        id: followerId,
        userId: currentUserData.id,
        userFollowedId: userSearchData.id);
    userSearchData.followerId = followerId;

    await _followerModel.addElement(followerData);
    await updateUserFollowData(userSearchData, currentUserData, true);
  }

  updateFollowCount(
      UserSearchData userData, UserSearchData currentUserData, bool add) {
    _updateFollowers(userData, add);
    _updateFollowing(currentUserData, add);
  }

  updateUserFollowData(
      UserSearchData userData, UserSearchData currentUserData, bool add) async {
    await _updateUser(userData);
    await _updateUser(currentUserData);
  }

  _updateFollowers(UserSearchData userData, bool add) {
    userData.followers += add ? 1 : -1;
    userData.followingFlag = add;
  }

  _updateFollowing(UserData userData, bool add) {
    userData.following += add ? 1 : -1;
  }

  Future<void> _updateUser(UserData userData) async {
    await _userModel.updateElement(userData.id, userData);
  }
}
