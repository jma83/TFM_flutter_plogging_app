import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/user_entity.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStoreService)
class UserStoreService implements IStoreService<User> {
  final FirebaseFirestore _firebaseFirestore;
  @override
  String entityName = "users";
  UserStoreService(this._firebaseFirestore);

  @override
  Future<void> addElement(User data) async {
    final Map<String, Object> userMap = castUserToMap(data);
    await entity.add(userMap);
  }

  @override
  Future<void> updateElement(String collectionId, User data) async {
    final Map<String, Object> userMap = castUserToMap(data);
    await entity.doc(collectionId).update(userMap);
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
  }

  Future<void> queryElementByCriteria(String key, String value) async {
    // entity.where(key, isEqualTo: value).get().then((value) => );
  }

  @override
  CollectionReference get entity {
    return _firebaseFirestore.collection(entityName);
  }

  @override
  Stream get elements {
    return entity.snapshots();
  }

  User? castObjectToUser(Object data) {
    return (data.runtimeType == User ? data : null) as User?;
  }

  Map<String, Object> castUserToMap(User user) {
    return {"username": user.username, "age": user.age, "gender": user.gender};
  }
}
