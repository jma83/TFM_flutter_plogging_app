import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/di/container.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/edit_profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/liked_routes_page.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';

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
