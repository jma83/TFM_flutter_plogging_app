import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/core/services/storage_service.dart';

final getIt = GetIt.instance;
final firestoneInstance = FirebaseFirestore.instance;
void $initModels() {
  getIt
    ..registerLazySingleton<UserModel>(
        () => UserModel(firestoneInstance, getIt<StorageService>()))
    ..registerLazySingleton<RouteModel>(
        () => RouteModel(firestoneInstance, getIt<StorageService>()))
    ..registerLazySingleton<FollowerModel>(
        () => FollowerModel(firestoneInstance))
    ..registerLazySingleton<LikeModel>(() => LikeModel(firestoneInstance));
}
