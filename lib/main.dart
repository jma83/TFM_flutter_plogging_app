import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/injection.config.dart';
import 'package:flutter_plogging/src/core/di/injection.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Env.Default);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      home: const StartPage(),
      navigatorKey: getIt<NavigationService>().navigatorKey,
    );
  }
}
