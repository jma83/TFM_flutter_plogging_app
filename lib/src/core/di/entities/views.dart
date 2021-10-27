import 'package:flutter_plogging/src/ui/pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page/register_page_viewmodel.dart';

final getIt = GetIt.instance;

void $initViews() {
  getIt
    ..registerFactory(() => LoginPage(getIt<LoginPageViewModel>()))
    ..registerFactory(() => StartPage(getIt<StartPageViewModel>()))
    ..registerFactory(() => RegisterPage(getIt<RegisterPageViewModel>()))
    ..registerFactory(() => const HomeTabBar());
}
