// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class StorageService {
  final FirebaseStorage _firebaseStorage;
  StorageService(this._firebaseStorage);

  Future<String> getImage(
      String entityName, String entityId, String resourceName) async {
    try {
      return await _firebaseStorage
          .ref()
          .child(entityName)
          .child(entityId)
          .child(resourceName)
          .getDownloadURL();
    } on FirebaseException catch (e) {
      if (e.code == "permission-denied" || e.code == "unauthorized") {
        print('User does not have permission to get from this reference.');
      }
      if (e.code == "object-not-found") {
        print('Resource not found');
      }

      return Future.value("");
    }
  }

  Future<void> setImage(String entityName, String entityId, String resourceName,
      File file) async {
    try {
      await _firebaseStorage
          .ref()
          .child(entityName)
          .child(entityId)
          .child(resourceName)
          .putFile(file);
    } on FirebaseException catch (e) {
      if (e.code == "permission-denied" || e.code == "unauthorized") {
        print('User does not have permission to get from this reference.');
        return;
      }
      if (e.code == "object-not-found") {
        print('Resource not found');
        return;
      }

      print("Error generico! $e");
    }
  }
}
