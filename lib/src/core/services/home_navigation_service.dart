import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_navigation_service.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: INavigationService)
class HomeNavigationService implements INavigationService {
  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys;
  TabItem currentTabItem;
  HomeNavigationService(this._navigatorKeys,
      {this.currentTabItem = TabItem.home});
  StreamController<GlobalKey<NavigatorState>> controller =
      StreamController<GlobalKey<NavigatorState>>();

  @override
  Future<dynamic> navigateTo(Route route) {
    return _navigatorKey.currentState!.push(route);
  }

  @override
  Future<dynamic> navigateToByName(String routeName) {
    return _navigatorKey.currentState!.pushNamed(routeName);
  }

  @override
  Future<dynamic> navigateAndReplaceTo(Route route) {
    return _navigatorKey.currentState!.pushReplacement(route);
  }

  @override
  Future<dynamic> navigateAndReplaceToByName(String routeName) {
    return _navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  @override
  Widget getRouteWidget(String routeName) {
    return getRoute(routeName);
  }

  @override
  void goBack() {
    return _navigatorKey.currentState!.pop();
  }

  setCurrentTabItem(TabItem currentTabItem) {
    this.currentTabItem = currentTabItem;
    controller.add(_navigatorKey);
  }

  GlobalKey<NavigatorState> get _navigatorKey {
    return _navigatorKeys[currentTabItem]!;
  }

  Stream<GlobalKey<NavigatorState>> streamCurrentTabItem() {
    return controller.stream;
  }

  Widget? get currentWidget {
    return _navigatorKeys[currentTabItem]!.currentWidget;
  }
}
