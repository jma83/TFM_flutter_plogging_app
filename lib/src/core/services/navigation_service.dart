import 'package:flutter/widgets.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_navigation_service.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: INavigationService)
class NavigationService implements INavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

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
  Widget getRouteWidget(String routeName) {
    print("routeName $routeName");
    return getRoute(routeName);
  }

  @override
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
