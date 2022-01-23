import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {Key? key,
      required this.navigatorKey,
      required this.routeBuilders,
      required this.initialRoute})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;
  final Function routeBuilders;
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) {
            return routeBuilders(routeSettings.name)!(context);
          });
        });
  }
}
