import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
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
      this.image = ""});
}

class UserFieldData {
  static const String username = "username";
  static const String age = "age";
  static const String gender = "gender";
  static const String followers = "followers";
  static const String following = "following";
  static const String xp = "xp";
  static const String level = "level";
  static const String image = "image";
}
