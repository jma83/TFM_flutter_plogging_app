class FollowerData {
  String userId;
  String userFollowedId;
  FollowerData({required this.userId, required this.userFollowedId});

  static Map<String, Object> castFollowerToMap(FollowerData followerData) {
    return {
      FollowerFieldData.userId: followerData.userId,
      FollowerFieldData.userFollowedId: followerData.userFollowedId,
    };
  }

  static FollowerData castMapToFollower(Map<String, dynamic> map) {
    return FollowerData(
        userId: map[FollowerFieldData.userId] as String,
        userFollowedId: map[FollowerFieldData.userFollowedId] as String);
  }
}

class FollowerFieldData {
  static const String userId = "userId";
  static const String userFollowedId = "userFollowedId";
}
