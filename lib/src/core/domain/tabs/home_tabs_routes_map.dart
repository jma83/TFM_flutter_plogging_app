import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';

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

getHomeTabFromRoute(String route) {
  switch (route) {
    case Ruta.Home:
      return TabItem.home;
    case Ruta.Search:
      return TabItem.search;
    case Ruta.Plogging:
      return TabItem.plogging;
    case Ruta.MyRoutes:
      return TabItem.myRoutes;
    case Ruta.Profile:
      return TabItem.profile;
    default:
      return TabItem.home;
  }
}
