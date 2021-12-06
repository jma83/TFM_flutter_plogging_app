class FollowerData {
  String id;
  String userId;
  String userFollowedId;
  FollowerData(
      {required this.userId, required this.userFollowedId, this.id = ""});

  static Map<String, Object> castFollowerToMap(FollowerData followerData) {
    return {
      FollowerFieldData.userId: followerData.userId,
      FollowerFieldData.userFollowedId: followerData.userFollowedId,
    };
  }

  static FollowerData castMapToFollower(Map<String, dynamic> map, String id) {
    return FollowerData(
        id: id,
        userId: map[FollowerFieldData.userId] as String,
        userFollowedId: map[FollowerFieldData.userFollowedId] as String);
  }
}

class FollowerFieldData {
  static const String id = "id";
  static const String userId = "userId";
  static const String userFollowedId = "userFollowedId";
}
