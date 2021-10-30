import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';

final getIt = GetIt.instance;

void $initRouteCoordinators() {
  getIt
    ..registerFactory(() => StartRouteCoordinator(
        getIt<StartPage>(),
        getIt<NavigationService>(),
        getIt<LoginRouteCoordinator>(),
        getIt<MainRouteCoordinator>()))
    ..registerFactory(() =>
        LoginRouteCoordinator(getIt<LoginPage>(), getIt<NavigationService>()))
    ..registerFactory(() =>
        MainRouteCoordinator(getIt<HomeTabBar>(), getIt<NavigationService>()));
}
