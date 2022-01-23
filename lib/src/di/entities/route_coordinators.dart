import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/profile_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/search_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/start_plogging_page_view.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/pages/login_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/start_page_view.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initRouteCoordinators() {
  getIt
    ..registerFactory(() => StartRouteCoordinator(
        getIt<StartPageView>(), getIt<NavigationService>()))
    ..registerFactory(() => LoginRouteCoordinator(
        getIt<LoginPageView>(), getIt<NavigationService>()))
    ..registerFactory(() => MainRouteCoordinator(
        getIt<HomeTabBarView>(), getIt<NavigationService>()))
    ..registerFactory(() => HomeRouteCoordinator(
        getIt<HomePageView>(), getIt<NavigationService>(), TabItem.home))
    ..registerFactory(() => SearchRouteCoordinator(
        getIt<SearchPageView>(), getIt<NavigationService>(), TabItem.search))
    ..registerFactory(() => StartPloggingRouteCoordinator(
        getIt<StartPloggingPageView>(),
        getIt<NavigationService>(),
        TabItem.plogging))
    ..registerFactory(() => MyRoutesRouteCoordinator(getIt<MyRoutesPageView>(),
        getIt<NavigationService>(), TabItem.myRoutes))
    ..registerFactory(() => ProfileRouteCoordinator(
        getIt<ProfilePageView>(), getIt<NavigationService>(), TabItem.profile));
  //HomeRouteCoordinator
}
