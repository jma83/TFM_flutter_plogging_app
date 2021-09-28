// ignore_for_file: constant_identifier_names

import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:injectable/injectable.dart';

@injectableInit
void configureInjection(String enviroment) =>
    $initGetIt(environment: enviroment);

abstract class Env {
  static const Default = 'default';
}
