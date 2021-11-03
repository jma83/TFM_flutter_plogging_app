import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/tabs/home_nav_items.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';

final getIt = GetIt.instance;

void $initViews() {
  getIt
    ..registerFactory(() => LoginPage(getIt<LoginPageViewModel>()))
    ..registerFactory(() => StartPage(getIt<StartPageViewModel>()))
    ..registerFactory(() => RegisterPage(getIt<RegisterPageViewModel>()))
    ..registerFactory(() => HomePage())
    ..registerFactory(() => SearchPage())
    ..registerFactory(() => StartPloggingPage())
    ..registerFactory(() => MyRoutesPage())
    ..registerFactory(() => ProfilePage());
}
