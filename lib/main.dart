import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plogging/src/di/container.dart';
import 'package:flutter_plogging/src/di/injection.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_route_coordinator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Env.Default);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black87,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.green,
            backgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              color: Colors.black87,
            )),
        home: getIt<StartRouteCoordinator>().mainWidget,
        navigatorKey: getIt<NavigationService>().currentNavigator,
        builder: getIt<LoadingService>().init());
  }
}
