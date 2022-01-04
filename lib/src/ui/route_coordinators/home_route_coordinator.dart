import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRouteCoordinator extends HomeTabRouteCoordinator {
  HomeRouteCoordinator(
      HomePage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(
        () => navigateToRoute(mainWidget.viewModel.selectedRoute,
            mainWidget.viewModel.selectedAuthor),
        [HomeNotifiers.navigateToRoute]);
    viewModels.add(mainWidget.viewModel);
  }

  navigateToRoute(RouteListData? routeListData, UserSearchData? userData) {
    if (routeListData == null || userData == null) return;
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }
}
