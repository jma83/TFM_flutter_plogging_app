import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';

Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.search: GlobalKey<NavigatorState>(),
  TabItem.plogging: GlobalKey<NavigatorState>(),
  TabItem.myRoutes: GlobalKey<NavigatorState>(),
  TabItem.profile: GlobalKey<NavigatorState>(),
};
