import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRouteCoordinator extends ParentRouteCoordinator {
  HomeRouteCoordinator(
      HomePage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(
        () => navigateToRoute(mainWidget.viewModel.selectedRoute,
            mainWidget.viewModel.selectedAuthor),
        [HomeNotifiers.navigateToRoute]);
  }

  @override
  updateRoute() {
    viewModels.forEach((element) => element.loadPage());
    (mainWidget as HomePage).viewModel.loadPage();
  }

  @override
  updatePageData(RouteListAuthorSearchData data) {
    viewModels.forEach((element) {
      element.updateData(data);
    });
    (mainWidget as HomePage).viewModel.updateData(data);
  }

  navigateToRoute(RouteListData routeListData, UserData userData) {
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }

  navigateToUserDetail(UserData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }
}
