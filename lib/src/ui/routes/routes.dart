import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/secondary/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/secondary/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';

Map<String, WidgetBuilder> getRoutesBuilder() {
  return <String, WidgetBuilder>{
    Ruta.Start: (BuildContext context) => getIt<StartPage>(),
    Ruta.Login: (BuildContext context) => getIt<LoginPage>(),
    Ruta.Register: (BuildContext context) => getIt<RegisterPage>(),
    Ruta.HomeTab: (BuildContext context) => getIt<HomeTabBar>(),
    Ruta.Home: (BuildContext context) => getIt<HomePage>(),
    Ruta.Search: (BuildContext context) => getIt<SearchPage>(),
    Ruta.Plogging: (BuildContext context) => getIt<StartPloggingPage>(),
    Ruta.MyRoutes: (BuildContext context) => getIt<MyRoutesPage>(),
    Ruta.Profile: (BuildContext context) => getIt<ProfilePage>()
  };
}

Map<String, ParentRouteCoordinator> getRoutesByCoordinator() {
  return <String, ParentRouteCoordinator>{
    Ruta.Start: getIt<StartRouteCoordinator>(),
    Ruta.Login: getIt<LoginRouteCoordinator>(),
    Ruta.HomeTab: getIt<MainRouteCoordinator>(),
    Ruta.Home: getIt<HomeRouteCoordinator>(),
    Ruta.Search: getIt<SearchRouteCoordinator>(),
    Ruta.Plogging: getIt<StartPloggingRouteCoordinator>(),
    Ruta.MyRoutes: getIt<MyRoutesRouteCoordinator>(),
    Ruta.Profile: getIt<ProfileRouteCoordinator>()
  };
}

Map<String, WidgetBuilder> getRoutesBuilderByCoordinator() {
  return <String, WidgetBuilder>{
    Ruta.Start: (BuildContext context) =>
        getIt<StartRouteCoordinator>().mainWidget,
    Ruta.Login: (BuildContext context) =>
        getIt<LoginRouteCoordinator>().mainWidget,
    Ruta.HomeTab: (BuildContext context) =>
        getIt<MainRouteCoordinator>().mainWidget,
    Ruta.Home: (BuildContext context) =>
        getIt<HomeRouteCoordinator>().getAndUpdateWidget(),
    Ruta.Search: (BuildContext context) =>
        getIt<SearchRouteCoordinator>().getAndUpdateWidget(),
    Ruta.Plogging: (BuildContext context) =>
        getIt<StartPloggingRouteCoordinator>().getAndUpdateWidget(),
    Ruta.MyRoutes: (BuildContext context) =>
        getIt<MyRoutesRouteCoordinator>().getAndUpdateWidget(),
    Ruta.Profile: (BuildContext context) =>
        getIt<ProfileRouteCoordinator>().getAndUpdateWidget()
  };
}

Map<TabItem, HomeTabRouteCoordinator> getHomeTabsByCoordinator() {
  return <TabItem, HomeTabRouteCoordinator>{
    TabItem.home: getIt<HomeRouteCoordinator>(),
    TabItem.search: getIt<SearchRouteCoordinator>(),
    TabItem.plogging: getIt<StartPloggingRouteCoordinator>(),
    TabItem.myRoutes: getIt<MyRoutesRouteCoordinator>(),
    TabItem.profile: getIt<ProfileRouteCoordinator>()
  };
}

Widget getRoute(String route) {
  switch (route) {
    case Ruta.Start:
      return getIt<StartPage>();
    case Ruta.Login:
      return getIt<LoginPage>();
    case Ruta.Register:
      return getIt<RegisterPage>();
    case Ruta.Home:
      return getIt<HomeTabBar>();
    case Ruta.RouteDetail:
      return getIt<RouteDetailPage>();
    case Ruta.UserDetail:
      return getIt<UserDetailPage>();
    default:
      return getIt<StartPage>();
  }
}
