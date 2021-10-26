import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';

Map<String, WidgetBuilder> getRoutesBuilder() {
  return <String, WidgetBuilder>{
    Ruta.Start.getValue(): (BuildContext context) => getIt<StartPage>(),
    Ruta.Login.getValue(): (BuildContext context) => getIt<LoginPage>(),
    Ruta.Register.getValue(): (BuildContext context) => const RegisterPage(),
    Ruta.Home.getValue(): (BuildContext context) => const HomePage(),
  };
}

Map<String, Widget> getRoutes() {
  return <String, Widget>{
    Ruta.Start.getValue(): getIt<StartPage>(),
    Ruta.Login.getValue(): getIt<LoginPage>(),
    Ruta.Register.getValue(): const RegisterPage(),
    Ruta.Home.getValue(): const HomePage(),
  };
}
