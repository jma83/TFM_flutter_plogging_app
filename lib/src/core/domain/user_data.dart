class UserData {
  String username;
  int age;
  int gender;
  int followers;
  int following;
  int xp;
  int level;
  UserData(
      {this.username = "",
      this.age = 18,
      this.gender = 0,
      this.followers = 0,
      this.following = 0,
      this.xp = 0,
      this.level = 1});
}

class UserFieldData {
  static const String username = "username";
  static const String age = "age";
  static const String gender = "gender";
  static const String followers = "followers";
  static const String following = "following";
  static const String xp = "xp";
  static const String level = "level";
}
