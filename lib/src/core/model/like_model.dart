import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/like_data.dart';
import 'package:flutter_plogging/src/core/model/interfaces/i_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IModel)
class LikeModel implements IModel<LikeData> {
  final FirebaseFirestore _firebaseFirestore;
  @override
  String entityName = "likes";
  LikeModel(this._firebaseFirestore);

  @override
  Future<void> addElement(LikeData data) async {
    final Map<String, Object> followerMap = LikeData.castLikeToMap(data);
    entity.doc(data.id).set(followerMap);
  }

  @override
  Future<void> updateElement(String collectionId, LikeData data) async {
    final Map<String, Object> followerMap = LikeData.castLikeToMap(data);
    await entity.doc(collectionId).update(followerMap);
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
  }

  @override
  Future<LikeData?> queryElementById(String id) async {
    final docData = await entity.doc(id).get();
    if (docData.data() == null) {
      return null;
    }
    Map<String, dynamic> mapData = docData.data() as Map<String, dynamic>;
    LikeData result = LikeData.castMapToLike(mapData, id);
    return result;
  }

  Query<Object?> queryByEqualCriteria(
      String key, String value, Query<Object?> query) {
    return query.where(key, isEqualTo: value);
  }

  Query<Object?> queryInCriteria(
      String key, List<String> value, Query<Object?> query) {
    return query.where(key, whereIn: value);
  }

  Future<List<LikeData>> matchRoutesWithUserLikes(
      String userId, List<String> routeIds) async {
    Query<Object?> query =
        queryByEqualCriteria(LikeFieldData.userId, userId, entity);
    query = queryInCriteria(LikeFieldData.routeId, routeIds, query);
    final docsData = await query.get();

    return docsData.docs
        .map((e) =>
            LikeData.castMapToLike(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<LikeData>> queryElementEqualByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await queryByEqualCriteria(key, value, entity).get();
    return docsData.docs
        .map((e) =>
            LikeData.castMapToLike(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<LikeData>> queryElementInCriteria(
      String key, List<String> values) async {
    final QuerySnapshot<Object?> docsData =
        await queryInCriteria(key, values, entity).get();
    return docsData.docs
        .map((e) =>
            LikeData.castMapToLike(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<LikeData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData = await entity
        .orderBy(LikeFieldData.userId)
        .startAt([value]).endAt([value + '\uf8ff']).get();
    return docsData.docs
        .map((e) =>
            LikeData.castMapToLike(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  CollectionReference get entity {
    return _firebaseFirestore.collection(entityName);
  }

  @override
  Stream get elements {
    return entity.snapshots();
  }
}
