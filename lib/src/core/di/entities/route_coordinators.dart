import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_nav_items.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';

final getIt = GetIt.instance;

void $initRouteCoordinators() {
  getIt
    ..registerFactory(() => StartRouteCoordinator(
        getIt<StartPage>(), getIt<NavigationService>(), null))
    ..registerFactory(() => LoginRouteCoordinator(
        getIt<LoginPage>(), getIt<NavigationService>(), null))
    ..registerFactory(() => MainRouteCoordinator(
        getIt<HomeTabBar>(), getIt<NavigationService>(), null))
    ..registerLazySingleton(() => HomeRouteCoordinator(
        getIt<HomePage>(), getIt<NavigationService>(), TabItem.home))
    ..registerLazySingleton(() => SearchRouteCoordinator(
        getIt<SearchPage>(), getIt<NavigationService>(), TabItem.search))
    ..registerLazySingleton(() => StartPloggingRouteCoordinator(
        getIt<StartPloggingPage>(),
        getIt<NavigationService>(),
        TabItem.plogging))
    ..registerLazySingleton(() => MyRoutesRouteCoordinator(
        getIt<MyRoutesPage>(), getIt<NavigationService>(), TabItem.myRoutes))
    ..registerLazySingleton(() => ProfileRouteCoordinator(
        getIt<ProfilePage>(), getIt<NavigationService>(), TabItem.profile))
    ..registerLazySingleton(
        () => HomeTabBar(navbarItems, getIt<NavigationService>()));
  //HomeRouteCoordinator
}
