import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    Ruta.Start.getValue(): (BuildContext context) => const StartPage(),
    Ruta.Login.getValue(): (BuildContext context) => const LoginPage(),
    Ruta.Register.getValue(): (BuildContext context) => const RegisterPage(),
    Ruta.Home.getValue(): (BuildContext context) => const HomePage(),
  };
}
