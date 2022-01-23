import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/di/container.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar_view.dart';
import 'package:flutter_plogging/src/ui/pages/register_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/start_page_view.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/login_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/edit_profile_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/liked_routes_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/how_it_works_page_view.dart';

Widget getRoute(String route) {
  switch (route) {
    case Ruta.Start:
      return getIt<StartPageView>();
    case Ruta.Login:
      return getIt<LoginPageView>();
    case Ruta.Register:
      return getIt<RegisterPageView>();
    case Ruta.Home:
      return getIt<HomeTabBarView>();
    case Ruta.RouteDetail:
      return getIt<RouteDetailPageView>();
    case Ruta.UserDetail:
      return getIt<UserDetailPageView>();
    case Ruta.EditProfile:
      return getIt<EditProfilePageView>();
    case Ruta.LikedRoutes:
      return getIt<LikedRoutesPageView>();
    case Ruta.HowItWorks:
      return getIt<HowItWorksPageView>();
    default:
      return getIt<StartPageView>();
  }
}
