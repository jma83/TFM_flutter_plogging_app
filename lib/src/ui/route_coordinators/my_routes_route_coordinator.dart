import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/my_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyRoutesRouteCoordinator extends HomeTabRouteCoordinator {
  RouteDetailPage? routeDetailPage;
  UserDetailPage? userDetailPage;
  MyRoutesRouteCoordinator(
      MyRoutesPage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(
        () => navigateToRoute(mainWidget.viewModel.selectedRoute,
            mainWidget.viewModel.selectedAuthor),
        [MyRouteNotifiers.navigateToRoute]);
    viewModels.add(mainWidget.viewModel);
  }

  navigateToRoute(RouteListData routeListData, UserSearchData userData) {
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }
}
