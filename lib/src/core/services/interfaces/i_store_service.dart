import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IStoreService<T> {
  Future<void> addElement(T data);
  Future<void> updateElement(String collectionId, T data);
  Future<void> removeElement(String collectionId);
  final CollectionReference? entity = null;
  final Stream? elements = null;
  late String entityName = "";
}
