import 'package:flutter/widgets.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_navigation_service.dart';
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
  Future<dynamic> navigateAndReplaceTo(Route route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  @override
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
