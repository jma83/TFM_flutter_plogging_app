import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/model/interfaces/i_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IModel)
class FollowerModel implements IModel<FollowerData> {
  final FirebaseFirestore _firebaseFirestore;
  @override
  String entityName = "followers";
  FollowerModel(this._firebaseFirestore);

  @override
  Future<void> addElement(FollowerData data) async {
    final Map<String, Object> followerMap =
        FollowerData.castFollowerToMap(data);
    entity.doc(data.id).set(followerMap);
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
    FollowerData result = FollowerData.castMapToFollower(mapData, id);
    return result;
  }

  @override
  Future<List<FollowerData>> queryElementEqualByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await entity.where(key, isEqualTo: value).get();
    return docsData.docs
        .map((e) => FollowerData.castMapToFollower(
            e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<FollowerData>> queryElementInCriteria(
      String key, List<String> values) async {
    final QuerySnapshot<Object?> docsData =
        await entity.where(key, whereIn: values).get();
    return docsData.docs
        .map((e) => FollowerData.castMapToFollower(
            e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<FollowerData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData = await entity
        .orderBy(FollowerFieldData.userId)
        .startAt([value]).endAt([value + '\uf8ff']).get();
    return docsData.docs
        .map((e) => FollowerData.castMapToFollower(
            e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  Future<FollowerData?> isUserFollowed(
      String currentUserId, String userId) async {
    final QuerySnapshot<Object?> docsData = await entity
        .where(FollowerFieldData.userId, isEqualTo: currentUserId)
        .where(FollowerFieldData.userFollowedId, isEqualTo: userId)
        .get();
    if (docsData.docs.isEmpty) return null;
    String id = docsData.docs.first.id;
    Map<String, dynamic> followerData =
        docsData.docs.first.data() as Map<String, dynamic>;
    return FollowerData.castMapToFollower(followerData, id);
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
