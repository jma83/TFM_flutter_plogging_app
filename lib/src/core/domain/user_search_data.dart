import 'package:flutter_plogging/src/core/domain/user_data.dart';

class UserSearchData extends UserData {
  List<String> followingIds;
  List<String> followersIds;
  UserSearchData({
    required username,
    required age,
    required gender,
    followers,
    following,
    xp,
    level,
    image,
    this.followingIds = const [],
    this.followersIds = const [],
  }) : super(
            username: username,
            age: age,
            gender: gender,
            followers: followers,
            following: following,
            xp: xp,
            level: level,
            image: image);
}
