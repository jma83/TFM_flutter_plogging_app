import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/entity_data.dart';

class FollowerData extends EntityData {
  String id;
  String userId;
  String userFollowedId;
  Timestamp creationDate;
  FollowerData(
      {required this.userId,
      required this.userFollowedId,
      required this.creationDate,
      this.id = ""});

  static Map<String, Object> castFollowerToMap(FollowerData followerData) {
    return {
      FollowerFieldData.userId: followerData.userId,
      FollowerFieldData.userFollowedId: followerData.userFollowedId,
      FollowerFieldData.creationDate: followerData.creationDate,
    };
  }

  static FollowerData castMapToFollower(Map<String, dynamic> map, String id) {
    return FollowerData(
        id: id,
        userId: map[FollowerFieldData.userId] as String,
        userFollowedId: map[FollowerFieldData.userFollowedId] as String,
        creationDate: map[FollowerFieldData.creationDate] as Timestamp);
  }
}

class FollowerFieldData {
  static const String id = "id";
  static const String userId = "userId";
  static const String userFollowedId = "userFollowedId";
  static const String creationDate = "creationDate";
}
