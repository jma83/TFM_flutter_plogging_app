import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:flutter_plogging/src/core/services/storage_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IStoreService)
class RouteStoreService implements IStoreService<RouteData> {
  final FirebaseFirestore _firebaseFirestore;
  final StorageService _storageService;
  @override
  String entityName = "routes";
  RouteStoreService(this._firebaseFirestore, this._storageService);

  @override
  Future<void> addElement(RouteData data, String id) async {
    final Map<String, Object> userMap = castRouteToMap(data);
    entity.doc().set(userMap);
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
        await getQueryEqualByCriteria(key, value, entity).get();
    return docsData.docs
        .map((e) => castMapToRoute(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<RouteData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await getQueryLikeByCriteria(key, value, entity).get();
    return docsData.docs
        .map((e) => castMapToRoute(e.data() as Map<String, dynamic>))
        .toList();
  }

  Query<Object?> getQueryEqualByCriteria(
      String key, String value, Query<Object?> query) {
    return query.where(key, isEqualTo: value);
  }

  Query<Object?> getQueryLikeByCriteria(
      String key, String value, Query<Object?> query) {
    return query.orderBy(key).startAt([value]).endAt([value + '\uf8ff']);
  }

  Future<List<RouteData>> searchRoutesByNameAndAuthor(name, authorId) async {
    final Query<Object?> query1 =
        getQueryLikeByCriteria(RouteFieldData.name, name, entity);
    final QuerySnapshot<Object?> docsData =
        await getQueryEqualByCriteria(RouteFieldData.userId, authorId, query1)
            .get();
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
    await _storageService.setImage(entityName, id, "route.png", file);
  }

  @override
  Future<String> getImage(String id) async {
    return await _storageService.getImage(entityName, id, "route.png");
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
    final Timestamp startDate =
        route.startDate != null ? route.startDate! : Timestamp.now();
    final double distance = route.distance != null ? route.distance! : 0;
    final int duration = route.duration != null ? route.duration! : 0;
    List<GeoPoint> locationArray =
        route.locationArray != null ? route.locationArray! : [];
    Timestamp endDate =
        route.endDate != null ? route.endDate! : Timestamp.now();
    requiredFields.addAll({RouteFieldData.startDate: startDate});
    requiredFields.addAll({RouteFieldData.distance: distance});
    requiredFields.addAll({RouteFieldData.duration: duration});
    requiredFields.addAll({RouteFieldData.locationArray: locationArray});
    requiredFields.addAll({RouteFieldData.endDate: endDate});

    if (route.image != null) {
      requiredFields.addAll({RouteFieldData.image: route.image!});
    }
    return requiredFields;
  }

  RouteData castMapToRoute(Map<String, dynamic> map) {
    final image = map[RouteFieldData.image] != null
        ? map[RouteFieldData.image] as String
        : "";
    final originalList = map[RouteFieldData.locationArray] != null
        ? map[RouteFieldData.locationArray] as List<dynamic>
        : [];
    final List<GeoPoint> geoList = List<GeoPoint>.from(originalList.map(
        (elem) =>
            GeoPoint(elem["latitude"] as double, elem["longitude"] as double)));
    return RouteData(
        name: map[RouteFieldData.name] as String,
        description: map[RouteFieldData.description] as String,
        userId: map[RouteFieldData.userId] as String,
        duration: map[RouteFieldData.duration] as int,
        startDate: map[RouteFieldData.startDate] as Timestamp,
        endDate: map[RouteFieldData.endDate] as Timestamp,
        distance: map[RouteFieldData.distance] as double,
        image: image,
        locationArray: geoList);
  }
}
