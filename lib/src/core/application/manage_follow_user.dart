import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';

@injectable
class ManageFollowUser {
  final UuidGeneratorService _uuidGeneratorService;
  final FollowerModel _followerModel;
  final UserModel _userModel;
  final AuthenticationService _authenticationService;

  ManageFollowUser(this._uuidGeneratorService, this._followerModel,
      this._userModel, this._authenticationService);

  Future<void> execute(
      UserSearchData userData, Function updatePageCallback) async {
    userData.followingFlag = !userData.followingFlag;
    updatePageCallback();
    if (!userData.followingFlag) {
      await _removeElement(userData);
    } else {
      await _addElement(userData);
    }
  }

  _removeElement(UserSearchData userSearchData) async {
    final String followerId = userSearchData.followerId!;
    userSearchData.followerId = null;
    await _followerModel.removeElement(followerId);
    await updateFollowCount(userSearchData, false);
  }

  _addElement(UserSearchData userSearchData) async {
    final String followerId = _uuidGeneratorService.generate();
    final FollowerData followerData = FollowerData(
        id: followerId,
        userId: _authenticationService.currentUser!.uid,
        userFollowedId: userSearchData.id);
    userSearchData.followerId = followerId;

    await _followerModel.addElement(followerData);
    await updateFollowCount(userSearchData, true);
  }

  updateFollowCount(UserSearchData userData, bool add) async {
    final UserData currentUser = _authenticationService.currentUserData!;
    _updateFollowers(userData, add);
    await _updateUser(userData);

    _updateFollowing(currentUser, add);
    await _updateUser(currentUser);
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
