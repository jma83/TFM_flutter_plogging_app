import 'package:flutter_plogging/src/core/domain/route_progress_data.dart';
import 'package:flutter_plogging/src/core/services/follower_store_service.dart';
import 'package:flutter_plogging/src/core/services/like_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/my_routes_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/profile_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/search_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/start_plogging_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:flutter_plogging/src/core/services/route_store_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';

final getIt = GetIt.instance;

void $initViewModels() {
  getIt
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<StartPageViewModel>(() => StartPageViewModel(
        getIt<AuthenticationService>(), getIt<UserStoreService>()))
    ..registerFactory<RegisterPageViewModel>(() => RegisterPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<UserStoreService>()))
    ..registerFactory<LoginPageViewModel>(() => LoginPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<UserStoreService>()))
    ..registerFactory<HomePageViewModel>(() => HomePageViewModel(
        getIt<AuthenticationService>(),
        getIt<RouteStoreService>(),
        getIt<FollowerStoreService>(),
        getIt<LikeStoreService>()))
    ..registerFactory<StartPloggingPageViewModel>(() =>
        StartPloggingPageViewModel(
            getIt<AuthenticationService>(),
            getIt<RouteStoreService>(),
            getIt<GeolocatorService>(),
            getIt<UuidGeneratorService>(),
            getIt<ImagePickerService>(),
            RouteProgressData(id: getIt<UuidGeneratorService>().generate())))
    ..registerFactory<MyRoutesPageViewModel>(() => MyRoutesPageViewModel(
        getIt<AuthenticationService>(),
        getIt<RouteStoreService>(),
        getIt<LikeStoreService>(),
        getIt<UuidGeneratorService>()))
    ..registerFactory<ProfilePageViewModel>(() => ProfilePageViewModel(
        getIt<AuthenticationService>(), getIt<UserStoreService>()))
    ..registerFactory<SearchPageViewModel>(() => SearchPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserStoreService>(),
        getIt<FollowerStoreService>(),
        getIt<UuidGeneratorService>()));
}
