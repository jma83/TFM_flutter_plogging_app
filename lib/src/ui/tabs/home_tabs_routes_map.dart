import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';

Map<TabItem, String> homeTabsRoutesMap = {
  TabItem.home: Ruta.Home,
  TabItem.search: Ruta.Search,
  TabItem.plogging: Ruta.Plogging,
  TabItem.myRoutes: Ruta.MyRoutes,
  TabItem.profile: Ruta.Profile
};
Map<int, TabItem> homeTabsMap = {
  0: TabItem.home,
  1: TabItem.search,
  2: TabItem.plogging,
  3: TabItem.myRoutes,
  4: TabItem.profile
};
