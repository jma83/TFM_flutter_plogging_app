import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String username;
  int age;
  int gender;
  int followers;
  int following;
  int xp;
  int level;
  Timestamp creationDate = Timestamp.now();
  String? image;

  UserData(
      {required this.username,
      required this.age,
      required this.gender,
      this.followers = 0,
      this.following = 0,
      this.xp = 0,
      this.level = 1,
      this.image = "",
      this.id = ""});

  static Map<String, Object> castUserToMap(UserData user) {
    return {
      UserFieldData.username: user.username,
      UserFieldData.age: user.age,
      UserFieldData.gender: user.gender,
      UserFieldData.followers: user.followers,
      UserFieldData.following: user.following,
      UserFieldData.xp: user.xp,
      UserFieldData.level: user.level,
      UserFieldData.image: user.image != null ? user.image! : ""
    };
  }

  static UserData castMapToUser(Map<String, dynamic> map, String id) {
    final image = map[UserFieldData.image] != null
        ? map[UserFieldData.image] as String
        : "";
    return UserData(
        id: id,
        username: map[UserFieldData.username] as String,
        age: map[UserFieldData.age] as int,
        gender: map[UserFieldData.gender] as int,
        followers: map[UserFieldData.followers] as int,
        following: map[UserFieldData.following] as int,
        xp: map[UserFieldData.xp] as int,
        level: map[UserFieldData.level] as int,
        image: image);
  }
}

class UserFieldData {
  static const String id = "id";
  static const String username = "username";
  static const String age = "age";
  static const String gender = "gender";
  static const String followers = "followers";
  static const String following = "following";
  static const String xp = "xp";
  static const String level = "level";
  static const String image = "image";
}
