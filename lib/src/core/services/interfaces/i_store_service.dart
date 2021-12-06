import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IStoreService<T> {
  Future<void> addElement(T data, String id);
  Future<void> updateElement(String collectionId, T data);
  Future<void> removeElement(String collectionId);
  Future<T?> queryElementById(String id);
  Future<List<T>> queryElementEqualByCriteria(String key, String value);
  Future<List<T>> queryElementLikeByCriteria(String key, String value);
  Future<List<T>> queryElementInCriteria(String key, List<String> value);

  final CollectionReference? entity = null;
  final Stream? elements = null;
  late String entityName = "";
}
