import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';

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

Map<String, WidgetBuilder> getRoutesBuilderByCoordinator() {
  return <String, WidgetBuilder>{
    Ruta.Start: (BuildContext context) =>
        getIt<StartRouteCoordinator>().mainWidget,
    Ruta.Login: (BuildContext context) =>
        getIt<LoginRouteCoordinator>().mainWidget,
    Ruta.HomeTab: (BuildContext context) =>
        getIt<MainRouteCoordinator>().mainWidget,
    Ruta.Home: (BuildContext context) =>
        getIt<HomeRouteCoordinator>().mainWidget,
    Ruta.Search: (BuildContext context) =>
        getIt<SearchRouteCoordinator>().mainWidget,
    Ruta.Plogging: (BuildContext context) =>
        getIt<StartPloggingRouteCoordinator>().mainWidget,
    Ruta.MyRoutes: (BuildContext context) =>
        getIt<MyRoutesRouteCoordinator>().mainWidget,
    Ruta.Profile: (BuildContext context) =>
        getIt<ProfileRouteCoordinator>().mainWidget
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
    default:
      return getIt<StartPage>();
  }
}
