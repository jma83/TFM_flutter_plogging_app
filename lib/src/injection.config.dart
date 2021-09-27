import 'package:flutter_plogging/src/core/view_models/login_page/login_page_viewmodel.dart';
import 'package:flutter_plogging/src/core/view_models/register_page/register_page_viewmodel.dart';
import 'package:flutter_plogging/src/core/view_models/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initGetIt({String environment = Env.Default}) {
  getIt
    ..registerFactory<UserViewModel>(() => UserViewModel())
    ..registerFactory<RegisterPageViewModel>(
        () => RegisterPageViewModel(getIt<UserViewModel>()))
    ..registerFactory<LoginPageViewModel>(
        () => LoginPageViewModel(getIt<UserViewModel>()));
}
