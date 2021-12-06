import 'package:flutter_plogging/src/core/domain/user_data.dart';

class UserSearchData extends UserData {
  bool followingFlag;
  UserSearchData({required UserData user, this.followingFlag = false})
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
}
