import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/entity_data.dart';

class LikeData extends EntityData {
  String id;
  String userId;
  String routeId;
  Timestamp creationDate;
  LikeData(
      {required this.userId,
      required this.routeId,
      required this.creationDate,
      this.id = ""});

  static Map<String, Object> castLikeToMap(LikeData likeData) {
    return {
      LikeFieldData.userId: likeData.userId,
      LikeFieldData.routeId: likeData.routeId,
      LikeFieldData.creationDate: likeData.creationDate
    };
  }

  static LikeData castMapToLike(Map<String, dynamic> map, String id) {
    return LikeData(
        id: id,
        userId: map[LikeFieldData.userId] as String,
        routeId: map[LikeFieldData.routeId] as String,
        creationDate: map[LikeFieldData.creationDate] as Timestamp);
  }
}

class LikeFieldData {
  static const String id = "id";
  static const String userId = "userId";
  static const String routeId = "routeId";
  static const String creationDate = "creationDate";
}
