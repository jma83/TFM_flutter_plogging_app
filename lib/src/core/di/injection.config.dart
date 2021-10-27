import 'package:flutter_plogging/src/core/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/core/di/entities/services.dart';
import 'package:flutter_plogging/src/core/di/entities/viewmodels.dart';
import 'package:flutter_plogging/src/core/di/entities/views.dart';
import 'package:flutter_plogging/src/core/di/injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initGetIt({String environment = Env.Default}) {
  if (environment != Env.Default) {
    return;
  }
  $initServices();
  $initViewModels();
  $initViews();
  $initRouteCoordinators();
}
