import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/user_entity.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@LazySingleton(as: IStoreService)
class UserStoreService extends PropertyChangeNotifier<String>
    implements IStoreService {
  final FirebaseFirestore _firebaseFirestore;
  @override
  String entityName = "user";
  UserStoreService(this._firebaseFirestore);

  @override
  Future<void> addElement(Object data) async {
    await entity.add(data);
    notifyListeners("user_added");
  }

  @override
  Future<void> updateElement(String collectionId, Object data) async {
    User? user = castObjectToUser(data);
    if (user == null) return Future.value();

    final Map<String, Object> userMap = castUserToMap(user);
    await entity.doc(collectionId).update(userMap);
    notifyListeners("user_updated");
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
    notifyListeners("user_removed");
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
