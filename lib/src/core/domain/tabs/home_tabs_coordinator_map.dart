import 'package:flutter_plogging/src/di/container.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/my_routes_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/profile_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/search_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_plogging_route_coordinator.dart';

Map<TabItem, HomeTabRouteCoordinator> getHomeTabsByCoordinator() {
  return <TabItem, HomeTabRouteCoordinator>{
    TabItem.home: getIt<HomeRouteCoordinator>(),
    TabItem.search: getIt<SearchRouteCoordinator>(),
    TabItem.plogging: getIt<StartPloggingRouteCoordinator>(),
    TabItem.myRoutes: getIt<MyRoutesRouteCoordinator>(),
    TabItem.profile: getIt<ProfileRouteCoordinator>()
  };
}
