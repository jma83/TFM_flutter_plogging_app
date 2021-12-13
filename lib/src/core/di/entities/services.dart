import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/core/services/storage_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/tabs/home_tabs_routes_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;
final storageInstance = firebase_storage.FirebaseStorage.instance;

void $initServices() {
  getIt
    ..registerLazySingleton<NavigationService>(() => NavigationService(
        GlobalKey<NavigatorState>(), navigatorKeys, homeTabsRoutesMap))
    ..registerLazySingleton<AuthenticationService>(
        () => AuthenticationService(FirebaseAuth.instance))
    ..registerLazySingleton<StorageService>(
        () => StorageService(storageInstance))
    ..registerLazySingleton<GeolocatorService>(
        () => GeolocatorService(PolylinePoints()))
    ..registerLazySingleton<ImagePickerService>(
        () => ImagePickerService(ImagePicker()))
    ..registerLazySingleton<UuidGeneratorService>(
        () => UuidGeneratorService(const Uuid()));
}
