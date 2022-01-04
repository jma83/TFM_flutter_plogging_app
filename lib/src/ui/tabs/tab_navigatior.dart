import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator(
      {Key? key,
      required this.navigatorKey,
      required this.tabItem,
      required this.initialRoute})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routeBuilders = getRoutesBuilderByCoordinator();
    return Navigator(
        key: navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) {
            return routeBuilders[routeSettings.name]!(context);
          });
        });
  }
}
