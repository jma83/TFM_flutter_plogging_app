import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/edit_profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/liked_routes_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';

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
        getRouteByRouteCoordinator(Ruta.Start),
    Ruta.Login: (BuildContext context) =>
        getRouteByRouteCoordinator(Ruta.Login),
    Ruta.HomeTab: (BuildContext context) =>
        getRouteByRouteCoordinator(Ruta.HomeTab),
    Ruta.Home: (BuildContext context) => getRouteByRouteCoordinator(Ruta.Home),
    Ruta.Search: (BuildContext context) =>
        getRouteByRouteCoordinator(Ruta.Search),
    Ruta.Plogging: (BuildContext context) =>
        getRouteByRouteCoordinator(Ruta.Plogging),
    Ruta.MyRoutes: (BuildContext context) =>
        getRouteByRouteCoordinator(Ruta.MyRoutes),
    Ruta.Profile: (BuildContext context) =>
        getRouteByRouteCoordinator(Ruta.Profile)
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
    case Ruta.EditProfile:
      return getIt<EditProfilePage>();
    case Ruta.LikedRoutes:
      return getIt<LikedRoutesPage>();
    default:
      return getIt<StartPage>();
  }
}

HomeTabsChangeNotifier getHomeViewModelByRouteCoordinator(String route,
    {bool update = true}) {
  switch (route) {
    case Ruta.Home:
      return (getIt<HomeRouteCoordinator>().mainWidget as HomePage).viewModel;
    case Ruta.Search:
      return (getIt<SearchRouteCoordinator>().mainWidget as SearchPage)
          .viewModel;
    case Ruta.Plogging:
      return (getIt<StartPloggingRouteCoordinator>().mainWidget
              as StartPloggingPage)
          .viewModel;
    case Ruta.MyRoutes:
      return (getIt<MyRoutesRouteCoordinator>().mainWidget as MyRoutesPage)
          .viewModel;

    case Ruta.Profile:
      return (getIt<ProfileRouteCoordinator>().mainWidget as ProfilePage)
          .viewModel;
    default:
      return (getIt<HomeRouteCoordinator>().mainWidget as HomePage).viewModel;
  }
}

getRouteByRouteCoordinator(String route, {bool update = true}) {
  switch (route) {
    case Ruta.Start:
      return getIt<StartRouteCoordinator>().mainWidget as StartPage;
    case Ruta.Login:
      return getIt<LoginRouteCoordinator>().mainWidget as LoginPage;
    case Ruta.HomeTab:
      return getIt<MainRouteCoordinator>().mainWidget as HomeTabBar;
    case Ruta.Home:
      return update
          ? getIt<HomeRouteCoordinator>().getAndUpdateWidget() as HomePage
          : getIt<HomeRouteCoordinator>().mainWidget as HomePage;
    case Ruta.Search:
      return update
          ? getIt<SearchRouteCoordinator>().getAndUpdateWidget() as SearchPage
          : getIt<SearchRouteCoordinator>().mainWidget as SearchPage;
    case Ruta.Plogging:
      return update
          ? getIt<StartPloggingRouteCoordinator>().getAndUpdateWidget()
              as StartPloggingPage
          : getIt<StartPloggingRouteCoordinator>().mainWidget
              as StartPloggingPage;
    case Ruta.MyRoutes:
      return update
          ? getIt<MyRoutesRouteCoordinator>().getAndUpdateWidget()
              as MyRoutesPage
          : getIt<MyRoutesRouteCoordinator>().mainWidget as MyRoutesPage;
    case Ruta.Profile:
      return update
          ? getIt<ProfileRouteCoordinator>().getAndUpdateWidget() as ProfilePage
          : getIt<ProfileRouteCoordinator>().mainWidget as ProfilePage;
    default:
      return getIt<StartRouteCoordinator>().mainWidget as StartPage;
  }
}
