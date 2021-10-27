import 'package:flutter/widgets.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_navigation_service.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: INavigationService)
class NavigationService implements INavigationService {
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, Widget> routes = getRoutes();

  NavigationService(this.navigatorKey);

  @override
  Future<dynamic> navigateTo(Route route) {
    return navigatorKey.currentState!.push(route);
  }

  @override
  Future<dynamic> navigateToByName(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  @override
  Future<dynamic> navigateAndReplaceTo(Route route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  @override
  Future<dynamic> navigateAndReplaceToByName(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  @override
  Widget? getRouteWidget(String routeName) {
    Widget? routeWidget;
    print("routeName $routeName");
    routes.forEach((key, value) => {if (key == routeName) routeWidget = value});
    return routeWidget;
  }

  @override
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
