import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/edit_profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/liked_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/home_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/my_routes_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/profile_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/search_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/start_plogging_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/route_detail_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/user_detail_page_view_model.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tab_bar_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/edit_profile_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/liked_routes_page_viewmodel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initViews() {
  getIt
    ..registerFactory(() => HomeTabBar(getIt<HomeTabBarViewModel>()))
    ..registerFactory(() => LoginPage(getIt<LoginPageViewModel>()))
    ..registerFactory(() => StartPage(getIt<StartPageViewModel>()))
    ..registerFactory(() => RegisterPage(getIt<RegisterPageViewModel>()))
    ..registerFactory(() => HomePage(getIt<HomePageViewModel>()))
    ..registerFactory(() => SearchPage(getIt<SearchPageViewModel>()))
    ..registerFactory(
        () => StartPloggingPage(getIt<StartPloggingPageViewModel>()))
    ..registerFactory(() => MyRoutesPage(getIt<MyRoutesPageViewModel>()))
    ..registerFactory(() => ProfilePage(getIt<ProfilePageViewModel>()))
    ..registerFactory(() => RouteDetailPage(getIt<RouteDetailPageViewModel>()))
    ..registerFactory(() => UserDetailPage(getIt<UserDetailPageViewModel>()))
    ..registerFactory(() => EditProfilePage(getIt<EditProfilePageViewModel>()))
    ..registerFactory(() => LikedRoutesPage(getIt<LikedRoutesPageViewModel>()));
}
