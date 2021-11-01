import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';

final getIt = GetIt.instance;

void $initViewModels() {
  getIt
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<StartPageViewModel>(
        () => StartPageViewModel(getIt<AuthenticationService>()))
    ..registerFactory<RegisterPageViewModel>(() => RegisterPageViewModel(
        getIt<AuthenticationService>(),
        getIt<UserViewModel>(),
        getIt<UserStoreService>()))
    ..registerFactory<LoginPageViewModel>(() => LoginPageViewModel(
        getIt<AuthenticationService>(), getIt<UserViewModel>()));
}
