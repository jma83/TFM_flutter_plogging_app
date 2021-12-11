import 'package:flutter_plogging/src/core/domain/route_progress_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
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
import 'package:flutter_plogging/src/core/model/user_store_service.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/image_picker_service.dart';

final getIt = GetIt.instance;

void $initViewModels() {
  getIt
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<StartPageViewModel>(() =>
        StartPageViewModel(getIt<AuthenticationService>(), getIt<UserModel>()))
    ..registerFactory<RegisterPageViewModel>(() => RegisterPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<UserModel>()))
    ..registerFactory<LoginPageViewModel>(() => LoginPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<UserModel>()))
    ..registerFactory<HomePageViewModel>(() => HomePageViewModel(
        getIt<AuthenticationService>(),
        getIt<RouteModel>(),
        getIt<FollowerModel>(),
        getIt<LikeModel>()))
    ..registerFactory<StartPloggingPageViewModel>(() =>
        StartPloggingPageViewModel(
            getIt<AuthenticationService>(),
            getIt<RouteModel>(),
            getIt<GeolocatorService>(),
            getIt<UuidGeneratorService>(),
            getIt<ImagePickerService>(),
            RouteProgressData(id: getIt<UuidGeneratorService>().generate())))
    ..registerFactory<MyRoutesPageViewModel>(() => MyRoutesPageViewModel(
        getIt<AuthenticationService>(),
        getIt<RouteModel>(),
        getIt<LikeModel>(),
        getIt<UuidGeneratorService>()))
    ..registerFactory<ProfilePageViewModel>(() => ProfilePageViewModel(
        getIt<AuthenticationService>(), getIt<UserModel>()))
    ..registerFactory<SearchPageViewModel>(() => SearchPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserModel>(),
        getIt<FollowerModel>(),
        getIt<UuidGeneratorService>()));
}
