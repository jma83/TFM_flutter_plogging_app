import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/di/injection.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_page_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/register_page_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_page_route_coordinator.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initGetIt({String environment = Env.Default}) {
  if (environment != Env.Default) {
    return;
  }

  getIt
    ..registerLazySingleton<NavigationService>(() => NavigationService())
    ..registerFactory<AuthenticationService>(
        () => AuthenticationService(FirebaseAuth.instance))
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<StartPageRouteCoordinator>(
        () => StartPageRouteCoordinator(getIt<NavigationService>()))
    ..registerFactory<LoginPageRouteCoordinator>(
        () => LoginPageRouteCoordinator(getIt<NavigationService>()))
    ..registerFactory<RegisterPageRouteCoordinator>(
        () => RegisterPageRouteCoordinator(getIt<NavigationService>()))
    ..registerFactory<StartPageViewModel>(
        () => StartPageViewModel(getIt<StartPageRouteCoordinator>()))
    ..registerFactory<RegisterPageViewModel>(() => RegisterPageViewModel(
        getIt<RegisterPageRouteCoordinator>(), getIt<UserViewModel>()))
    ..registerFactory<LoginPageViewModel>(() => LoginPageViewModel(
        getIt<LoginPageRouteCoordinator>(), getIt<UserViewModel>()));
}
