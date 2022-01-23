import 'package:flutter_plogging/src/di/entities/application.dart';
import 'package:flutter_plogging/src/di/entities/models.dart';
import 'package:flutter_plogging/src/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/di/entities/services.dart';
import 'package:flutter_plogging/src/di/entities/viewmodels.dart';
import 'package:flutter_plogging/src/di/entities/views.dart';
import 'package:flutter_plogging/src/di/injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void $initGetIt({String environment = Env.Default}) {
  if (environment != Env.Default) {
    return;
  }
  $initServices(getIt);
  $initModels(getIt);
  $initApplication(getIt);
  $initViewModels(getIt);
  $initViews(getIt);
  $initRouteCoordinators(getIt);
}
