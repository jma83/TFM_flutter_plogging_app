import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/pages/login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    redirectOnTimeout(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: const [
              Image(
                image: AssetImage("assets/logo.png"),
                width: 220,
                height: 220,
              ),
              Text(
                "Plogging challenge",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.center,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }

  redirectOnTimeout(BuildContext context) {
    getFutureTimeout(context).then((route) => Navigator.push(context, route));
  }

  Future<MaterialPageRoute> getFutureTimeout(BuildContext context) {
    return Future.delayed(
      const Duration(seconds: 20),
      () {
        return MaterialPageRoute(builder: (context) => const LoginPage());
      },
    );
  }
}
