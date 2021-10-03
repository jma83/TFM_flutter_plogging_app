import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IStoreService {
  Future<void> addElement(Object data);
  Future<void> updateElement(String collectionId, Object data);
  Future<void> removeElement(String collectionId);
  final CollectionReference? entity = null;
  final Stream? elements = null;
  late String entityName = "";
}
