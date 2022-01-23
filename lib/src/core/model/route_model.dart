import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/model/interfaces/i_media_model.dart';
import 'package:flutter_plogging/src/core/services/storage_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMediaModel)
class RouteModel implements IMediaModel<RouteData> {
  final FirebaseFirestore _firebaseFirestore;
  final StorageService _storageService;
  @override
  String entityName = "routes";
  RouteModel(this._firebaseFirestore, this._storageService);

  @override
  Future<void> addElement(RouteData data) async {
    if (data.image != null && data.image != "") {
      await setImage(data.id!, File(data.image!));
      data.image = await getImage(data.id!);
    }
    final Map<String, Object> userMap = RouteData.castRouteToMap(data);
    entity.doc().set(userMap);
  }

  @override
  Future<void> updateElement(String collectionId, RouteData data) async {
    final Map<String, Object> userMap = RouteData.castRouteToMap(data);
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
    final result = RouteData.castMapToRoute(mapData, id);
    return result;
  }

  @override
  Future<List<RouteData>> queryElementEqualByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await _getQueryEqualByCriteria(key, value, entity).get();
    return docsData.docs
        .map((e) =>
            RouteData.castMapToRoute(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  @override
  Future<List<RouteData>> queryElementLikeByCriteria(
      String key, String value) async {
    final QuerySnapshot<Object?> docsData =
        await _getQueryLikeByCriteria(key, value, entity).get();
    return docsData.docs
        .map((e) =>
            RouteData.castMapToRoute(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  Query<Object?> _getQueryEqualByCriteria(
      String key, String value, Query<Object?> query) {
    return query.where(key, isEqualTo: value);
  }

  Query<Object?> _getQueryLikeByCriteria(
      String key, String value, Query<Object?> query) {
    return query.orderBy(key).startAt([value]).endAt([value + '\uf8ff']);
  }

  Future<List<RouteData>> searchRoutesByNameAndAuthor(name, authorId) async {
    final Query<Object?> query1 =
        _getQueryLikeByCriteria(RouteFieldData.name, name, entity);
    final QuerySnapshot<Object?> docsData =
        await _getQueryEqualByCriteria(RouteFieldData.userId, authorId, query1)
            .get();
    return docsData.docs
        .map((e) =>
            RouteData.castMapToRoute(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }

  Future<List<RouteData>> getRoutesbyDateAndUserId(
      Timestamp date, String authorId) async {
    final Query<Object?> query1 =
        _getQueryEqualByCriteria(RouteFieldData.userId, authorId, entity);
    final QuerySnapshot<Object?> docsData =
        await query1.where(RouteFieldData.startDate, isGreaterThan: date).get();
    return docsData.docs
        .map((e) =>
            RouteData.castMapToRoute(e.data() as Map<String, dynamic>, e.id))
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

  @override
  Future<List<RouteData>> queryElementInCriteria(
      String key, List<String> values) async {
    final dynamic finalKey =
        key == RouteFieldData.id ? FieldPath.documentId : key;
    final QuerySnapshot<Object?> docsData =
        await entity.where(finalKey, whereIn: values).get();
    return docsData.docs
        .map((e) =>
            RouteData.castMapToRoute(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
