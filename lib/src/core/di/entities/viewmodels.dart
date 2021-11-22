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

final getIt = GetIt.instance;

void $initViewModels() {
  getIt
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<StartPageViewModel>(
        () => StartPageViewModel(getIt<AuthenticationService>()))
    ..registerFactory<RegisterPageViewModel>(() => RegisterPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<UserStoreService>()))
    ..registerFactory<LoginPageViewModel>(() => LoginPageViewModel(
        getIt<AuthenticationService>(), getIt<UserViewModel>()))
    ..registerFactory<HomePageViewModel>(() => HomePageViewModel(
        getIt<AuthenticationService>(), getIt<UserStoreService>()))
    ..registerFactory<StartPloggingPageViewModel>(() =>
        StartPloggingPageViewModel(getIt<AuthenticationService>(),
            getIt<RouteStoreService>(), getIt<UiidGeneratorService>()))
    ..registerFactory<MyRoutesPageViewModel>(() => MyRoutesPageViewModel(
        getIt<AuthenticationService>(), getIt<RouteStoreService>()))
    ..registerFactory<ProfilePageViewModel>(
        () => ProfilePageViewModel(getIt<AuthenticationService>()))
    ..registerFactory<SearchPageViewModel>(() => SearchPageViewModel(
        getIt<AuthenticationService>(), getIt<UserStoreService>()));
}
