import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_navigation_service.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: INavigationService)
class NavigationService implements INavigationService {
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<TabItem, GlobalKey<NavigatorState>> homeNavigatorKeys;
  final Map<TabItem, String> homeTabsRoutesMap;
  NavigationService(
      this.navigatorKey, this.homeNavigatorKeys, this.homeTabsRoutesMap);
  TabItem? currentHomeTabItem;
  StreamController<TabItem?> controllerTabItem = BehaviorSubject<TabItem?>();
  @override
  Future<dynamic> navigateTo(Route route) {
    return currentNavigator.currentState!.push(route);
  }

  @override
  Future<dynamic> navigateToByName(String routeName) {
    return currentNavigator.currentState!.pushNamed(routeName);
  }

  @override
  Future<dynamic> navigateAndReplaceTo(Route route) {
    return currentNavigator.currentState!.pushReplacement(route);
  }

  @override
  Future<dynamic> navigateAndReplaceToByName(String routeName) {
    return currentNavigator.currentState!.pushReplacementNamed(routeName);
  }

  @override
  Widget getRouteWidget(String routeName) {
    return getRoute(routeName);
  }

  @override
  void goBack() {
    return navigatorKey.currentState != null
        ? navigatorKey.currentState!.pop()
        : currentNavigator.currentState!.pop();
  }

  setCurrentHomeTabItem(TabItem? tabItem) {
    controllerTabItem.add(tabItem);
    currentHomeTabItem = tabItem;
  }

  Widget? get currentWidget {
    return navigatorKey.currentWidget;
  }

  GlobalKey<NavigatorState> get currentNavigator {
    return homeNavigatorKeys[currentHomeTabItem] ?? navigatorKey;
  }

  Stream<TabItem?> getStreamHomeTabItem() {
    return controllerTabItem.stream;
  }
}
