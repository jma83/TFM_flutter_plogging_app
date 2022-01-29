// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_plogging/src/utils/app_constants.dart';
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
          .getDownloadURL()
          .timeout(const Duration(seconds: AppConstants.maxTimeLoadingImage));
    } on FirebaseException catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
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
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }
}
