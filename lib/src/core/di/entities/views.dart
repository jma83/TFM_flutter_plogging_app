import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/my_routes_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/profile_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/search_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/start_plogging_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/route_detail_page_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page_viewmodel.dart';

final getIt = GetIt.instance;

void $initViews() {
  getIt
    ..registerFactory(() => LoginPage(getIt<LoginPageViewModel>()))
    ..registerFactory(() => StartPage(getIt<StartPageViewModel>()))
    ..registerFactory(() => RegisterPage(getIt<RegisterPageViewModel>()))
    ..registerFactory(() => HomePage(getIt<HomePageViewModel>()))
    ..registerFactory(() => SearchPage(getIt<SearchPageViewModel>()))
    ..registerFactory(
        () => StartPloggingPage(getIt<StartPloggingPageViewModel>()))
    ..registerFactory(() => MyRoutesPage(getIt<MyRoutesPageViewModel>()))
    ..registerFactory(() => ProfilePage(getIt<ProfilePageViewModel>()))
    ..registerFactory(() => RouteDetailPage(getIt<RouteDetailPageViewModel>()));
}
