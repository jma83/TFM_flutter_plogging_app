import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/storage_service.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

void $initServices() {
  getIt
    ..registerLazySingleton<NavigationService>(
        () => NavigationService(GlobalKey<NavigatorState>()))
    ..registerLazySingleton<AuthenticationService>(
        () => AuthenticationService(FirebaseAuth.instance))
    ..registerLazySingleton<StorageService>(
        () => StorageService(firebase_storage.FirebaseStorage.instance))
    ..registerLazySingleton<UserStoreService>(() =>
        UserStoreService(FirebaseFirestore.instance, getIt<StorageService>()))
    ..registerLazySingleton<RouteStoreService>(() =>
        RouteStoreService(FirebaseFirestore.instance, getIt<StorageService>()))
    ..registerLazySingleton<UiidGeneratorService>(
        () => UiidGeneratorService(const Uuid()));
}
