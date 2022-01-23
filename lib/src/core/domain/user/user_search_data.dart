// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';

class UserSearchData extends UserData {
  bool followingFlag;
  String? followerId;
  UserSearchData(
      {required UserData user, this.followerId, this.followingFlag = false})
      : super(
            id: user.id,
            username: user.username,
            age: user.age,
            gender: user.gender,
            followers: user.followers,
            following: user.following,
            xp: user.xp,
            level: user.level,
            image: user.image);

  static List<UserSearchData> createListFromUsersAndFollows(
      List<UserData> users, List<FollowerData> follows) {
    return users.map((UserData user) {
      FollowerData? followerData = follows
          .firstWhereOrNull((element) => element.userFollowedId == user.id);
      return UserSearchData(
          user: user,
          followerId: followerData?.id,
          followingFlag: followerData != null);
    }).toList();
  }
}
