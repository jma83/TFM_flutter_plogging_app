class LikeData {
  String id;
  String userId;
  String routeId;
  LikeData({required this.userId, required this.routeId, this.id = ""});

  static Map<String, Object> castLikeToMap(LikeData likeData) {
    return {
      LikeFieldData.userId: likeData.userId,
      LikeFieldData.routeId: likeData.routeId,
    };
  }

  static LikeData castMapToLike(Map<String, dynamic> map, String id) {
    return LikeData(
        id: id,
        userId: map[LikeFieldData.userId] as String,
        routeId: map[LikeFieldData.routeId] as String);
  }
}

class LikeFieldData {
  static const String id = "id";
  static const String userId = "userId";
  static const String routeId = "routeId";
}
