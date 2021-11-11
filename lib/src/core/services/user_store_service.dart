import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStoreService)
class UserStoreService implements IStoreService<UserData> {
  final FirebaseFirestore _firebaseFirestore;
  @override
  String entityName = "users";
  UserStoreService(this._firebaseFirestore);

  @override
  Future<void> addElement(UserData data, String id) async {
    final Map<String, Object> userMap = castUserToMap(data);
    entity.doc(id).set(userMap);
  }

  @override
  Future<void> updateElement(String collectionId, UserData data) async {
    final Map<String, Object> userMap = castUserToMap(data);
    await entity.doc(collectionId).update(userMap);
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
  }

  @override
  Future<UserData?> queryElementById(String id) async {
    final docData = await entity.doc(id).get();
    Map<String, dynamic> mapData = docData.data() as Map<String, dynamic>;
    print("mapData $mapData");

    final result = castMapToUser(mapData);
    print("result $result");
    return result;
  }

  @override
  Future<QuerySnapshot<Object?>> queryElementByCriteria(
      String key, String value) async {
    return await entity.where(key, isEqualTo: value).get();
  }

  @override
  CollectionReference get entity {
    return _firebaseFirestore.collection(entityName);
  }

  @override
  Stream get elements {
    return entity.snapshots();
  }

  UserData? castObjectToUser(Object data) {
    return (data.runtimeType == UserData ? data : null) as UserData?;
  }

  Map<String, Object> castUserToMap(UserData user) {
    return {"username": user.username, "age": user.age, "gender": user.gender};
  }

  UserData castMapToUser(Map<String, dynamic> map) {
    return UserData(
        map["username"] as String, map["age"] as int, map["gender"] as int);
  }
}
