import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStoreService)
class RouteStoreService implements IStoreService<RouteData> {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  @override
  String entityName = "routes";
  RouteStoreService(this._firebaseFirestore, this._firebaseStorage);

  @override
  Future<void> addElement(RouteData data, String id) async {
    final Map<String, Object> userMap = castRouteToMap(data);
    entity.doc(id).set(userMap);
  }

  @override
  Future<void> updateElement(String collectionId, RouteData data) async {
    final Map<String, Object> userMap = castRouteToMap(data);
    await entity.doc(collectionId).update(userMap);
  }

  @override
  Future<void> removeElement(String collectionId) async {
    await entity.doc(collectionId).delete();
  }

  @override
  Future<RouteData?> queryElementById(String id) async {
    final docData = await entity.doc(id).get();
    if (docData.data() == null) {
      return null;
    }
    Map<String, dynamic> mapData = docData.data() as Map<String, dynamic>;
    final result = castMapToRoute(mapData);
    print("result $result");
    return result;
  }

  @override
  Future<List<RouteData>> queryElementEqualByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await entity.where(key, isEqualTo: value).get();
    return docsData.docs
        .map((e) => castMapToRoute(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<RouteData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData = await entity
        .orderBy(UserFieldData.username)
        .startAt([value]).endAt([value + '\uf8ff']).get();
    return docsData.docs
        .map((e) => castMapToRoute(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  CollectionReference get entity {
    return _firebaseFirestore.collection(entityName);
  }

  @override
  Future<void> setImage(String id, File file) async {
    await _firebaseStorage
        .ref()
        .child(entityName)
        .child(id)
        .child("route.png")
        .putFile(file);
  }

  @override
  Future<String> getImage(String id) async {
    return await _firebaseStorage
        .ref()
        .child(entityName)
        .child(id)
        .child("route.png")
        .getDownloadURL();
  }

  @override
  Stream get elements {
    return entity.snapshots();
  }

  RouteData? castObjectToUser(Object data) {
    return (data.runtimeType == RouteData ? data : null) as RouteData?;
  }

  Map<String, Object> castRouteToMap(RouteData route) {
    Map<String, Object> requiredFields = {
      RouteFieldData.name: route.name,
      RouteFieldData.description: route.description,
      RouteFieldData.userId: route.userId
    };
    if (route.startDate != null) {
      requiredFields.addAll({RouteFieldData.startDate: route.startDate!});
    }
    if (route.endDate != null) {
      requiredFields.addAll({RouteFieldData.endDate: route.endDate!});
    }
    if (route.duration != null) {
      requiredFields.addAll({RouteFieldData.duration: route.duration!});
    }
    if (route.distance != null) {
      requiredFields.addAll({RouteFieldData.distance: route.distance!});
    }
    if (route.image != null) {
      requiredFields.addAll({RouteFieldData.image: route.image!});
    }
    if (route.locationArray != null) {
      requiredFields
          .addAll({RouteFieldData.locationArray: route.locationArray!});
    }
    return requiredFields;
  }

  RouteData castMapToRoute(Map<String, dynamic> map) {
    return RouteData(
        name: map[RouteFieldData.name] as String,
        description: map[RouteFieldData.description] as String,
        userId: map[RouteFieldData.userId] as String,
        duration: map[RouteFieldData.duration] as int,
        startDate: map[RouteFieldData.startDate] as Timestamp,
        endDate: map[RouteFieldData.endDate] as Timestamp,
        distance: map[RouteFieldData.distance] as int,
        image: map[RouteFieldData.image] as String,
        locationArray: map[RouteFieldData.locationArray] as List<GeoPoint>);
  }
}
