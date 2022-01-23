import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initRouteCoordinators() {
  getIt
    ..registerFactory(() =>
        StartRouteCoordinator(getIt<StartPage>(), getIt<NavigationService>()))
    ..registerFactory(() =>
        LoginRouteCoordinator(getIt<LoginPage>(), getIt<NavigationService>()))
    ..registerFactory(() =>
        MainRouteCoordinator(getIt<HomeTabBar>(), getIt<NavigationService>()))
    ..registerFactory(() => HomeRouteCoordinator(
        getIt<HomePage>(), getIt<NavigationService>(), TabItem.home))
    ..registerFactory(() => SearchRouteCoordinator(
        getIt<SearchPage>(), getIt<NavigationService>(), TabItem.search))
    ..registerFactory(() => StartPloggingRouteCoordinator(
        getIt<StartPloggingPage>(),
        getIt<NavigationService>(),
        TabItem.plogging))
    ..registerFactory(() => MyRoutesRouteCoordinator(
        getIt<MyRoutesPage>(), getIt<NavigationService>(), TabItem.myRoutes))
    ..registerFactory(() => ProfileRouteCoordinator(
        getIt<ProfilePage>(), getIt<NavigationService>(), TabItem.profile));
  //HomeRouteCoordinator
}
