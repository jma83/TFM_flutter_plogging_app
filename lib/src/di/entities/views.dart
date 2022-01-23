import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/edit_profile_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/how_it_works_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/liked_routes_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/profile_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/search_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/start_plogging_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/login_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/register_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/start_page_view.dart';
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
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/how_it_works_page_viewmodel.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initViews() {
  getIt
    ..registerFactory(() => HomeTabBarView(getIt<HomeTabBarViewModel>()))
    ..registerFactory(() => LoginPageView(getIt<LoginPageViewModel>()))
    ..registerFactory(() => StartPageView(getIt<StartPageViewModel>()))
    ..registerFactory(() => RegisterPageView(getIt<RegisterPageViewModel>()))
    ..registerFactory(() => HomePageView(getIt<HomePageViewModel>()))
    ..registerFactory(() => SearchPageView(getIt<SearchPageViewModel>()))
    ..registerFactory(
        () => StartPloggingPageView(getIt<StartPloggingPageViewModel>()))
    ..registerFactory(() => MyRoutesPageView(getIt<MyRoutesPageViewModel>()))
    ..registerFactory(() => ProfilePageView(getIt<ProfilePageViewModel>()))
    ..registerFactory(
        () => RouteDetailPageView(getIt<RouteDetailPageViewModel>()))
    ..registerFactory(
        () => UserDetailPageView(getIt<UserDetailPageViewModel>()))
    ..registerFactory(
        () => EditProfilePageView(getIt<EditProfilePageViewModel>()))
    ..registerFactory(
        () => LikedRoutesPageView(getIt<LikedRoutesPageViewModel>()))
    ..registerFactory(
        () => HowItWorksPageView(getIt<HowItWorksPageViewModel>()));
}
