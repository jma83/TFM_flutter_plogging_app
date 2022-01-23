import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/interfaces/i_media_model.dart';
import 'package:flutter_plogging/src/core/services/storage_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMediaModel)
class UserModel implements IMediaModel<UserData> {
  final FirebaseFirestore _firebaseFirestore;
  final StorageService _storageService;
  @override
  String entityName = "users";
  UserModel(this._firebaseFirestore, this._storageService);

  @override
  Future<void> addElement(UserData data) async {
    final Map<String, Object> userMap = UserData.castUserToMap(data);
    entity.doc(data.id).set(userMap);
  }

  @override
  Future<void> updateElement(String collectionId, UserData data) async {
    if (data.image != null && data.image != "") {
      await setImage(data.id, File(data.image!));
      data.image = await getImage(data.id);
    }
    final Map<String, Object> userMap = UserData.castUserToMap(data);
    await entity.doc(collectionId).update(userMap);
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
  }

  @override
  Future<UserData?> queryElementById(String id) async {
    final docData = await entity.doc(id).get();
    if (docData.data() == null) {
      return null;
    }
    Map<String, dynamic> mapData = docData.data() as Map<String, dynamic>;
    UserData result = UserData.castMapToUser(mapData, id);
    result.image = await getImage(id);
    return result;
  }

  @override
  Future<List<UserData>> queryElementEqualByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await entity.where(key, isEqualTo: value).get();
    return docsData.docs
        .map((e) =>
            UserData.castMapToUser(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<UserData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData = await entity
        .orderBy(UserFieldData.username)
        .startAt([value]).endAt([value + '\uf8ff']).get();
    return docsData.docs
        .map((e) =>
            UserData.castMapToUser(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  Future<List<UserData>> getTopLevelUsers(int limit) async {
    final QuerySnapshot<Object?> docsData =
        await entity.orderBy(UserFieldData.level).limit(limit).get();
    return docsData.docs
        .map((e) =>
            UserData.castMapToUser(e.data() as Map<String, dynamic>, e.id))
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

  @override
  Future<void> setImage(String id, File file) async {
    await _storageService.setImage(entityName, id, "profile.png", file);
  }

  @override
  Future<String> getImage(String id) async {
    return await _storageService.getImage(entityName, id, "profile.png");
  }

  @override
  Future<List<UserData>> queryElementInCriteria(
      String key, List<String> values) async {
    final dynamic finalKey =
        key == UserFieldData.id ? FieldPath.documentId : key;
    final QuerySnapshot<Object?> docsData =
        await entity.where(finalKey, whereIn: values).get();
    return docsData.docs
        .map((e) =>
            UserData.castMapToUser(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
