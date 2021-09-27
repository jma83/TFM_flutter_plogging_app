import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Route route) {
    return navigatorKey.currentState!.push(route);
  }

  Future<dynamic> navigateAndReplaceTo(Route route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
