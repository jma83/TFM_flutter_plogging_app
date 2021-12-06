import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStoreService)
class FollowerStoreService implements IStoreService<FollowerData> {
  final FirebaseFirestore _firebaseFirestore;
  @override
  String entityName = "followers";
  FollowerStoreService(this._firebaseFirestore);

  @override
  Future<void> addElement(FollowerData data, String id) async {
    final Map<String, Object> followerMap =
        FollowerData.castFollowerToMap(data);
    entity.doc(id).set(followerMap);
  }

  @override
  Future<void> updateElement(String collectionId, FollowerData data) async {
    final Map<String, Object> followerMap =
        FollowerData.castFollowerToMap(data);
    await entity.doc(collectionId).update(followerMap);
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
  }

  @override
  Future<FollowerData?> queryElementById(String id) async {
    final docData = await entity.doc(id).get();
    if (docData.data() == null) {
      return null;
    }
    Map<String, dynamic> mapData = docData.data() as Map<String, dynamic>;
    FollowerData result = FollowerData.castMapToFollower(mapData);
    return result;
  }

  @override
  Future<List<FollowerData>> queryElementEqualByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await entity.where(key, isEqualTo: value).get();
    return docsData.docs
        .map((e) =>
            FollowerData.castMapToFollower(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<FollowerData>> queryElementInCriteria(
      String key, List<String> values) async {
    final QuerySnapshot<Object?> docsData =
        await entity.where(key, whereIn: values).get();
    return docsData.docs
        .map((e) =>
            FollowerData.castMapToFollower(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<FollowerData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData = await entity
        .orderBy(FollowerFieldData.userId)
        .startAt([value]).endAt([value + '\uf8ff']).get();
    return docsData.docs
        .map((e) =>
            FollowerData.castMapToFollower(e.data() as Map<String, dynamic>))
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
