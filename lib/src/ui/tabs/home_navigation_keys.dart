import 'package:flutter/material.dart';

enum TabItem { home, search, plogging, myRoutes, profile }

Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.search: GlobalKey<NavigatorState>(),
  TabItem.plogging: GlobalKey<NavigatorState>(),
  TabItem.myRoutes: GlobalKey<NavigatorState>(),
  TabItem.profile: GlobalKey<NavigatorState>(),
};
