import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRouteCoordinator extends ParentRouteCoordinator {
  RouteDetailPage? routeDetailPage;
  UserDetailPage? userDetailPage;
  HomeRouteCoordinator(HomePage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(
        () => navigateToRoute(mainWidget.viewModel.selectedRoute,
            mainWidget.viewModel.selectedAuthor),
        [HomeNotifiers.navigateToRoute]);
  }

  @override
  updateRoute() {
    (mainWidget as HomePage).viewModel.updatePage();
    routeDetailPage?.viewModel.updatePage();
    userDetailPage?.viewModel.updatePage();
  }

  navigateToRoute(RouteListData routeListData, UserData userData) {
    final HomePage mainWidgetHome = mainWidget as HomePage;
    routeDetailPage = genericNavigateToRoute(
        routeListData,
        userData,
        (userData) => navigateToUserDetail(userData),
        () => mainWidgetHome.viewModel.updatePage());
    userDetailPage = null;

    navigationService.setCurrentHomeTabItem(TabItem.home);
    navigationService.navigateTo(routeBuild(routeDetailPage!));
  }

  navigateToUserDetail(UserData userData) async {
    userDetailPage = genericNavigateToUser(userData, navigateToRoute);

    routeDetailPage = null;
    navigationService.setCurrentHomeTabItem(TabItem.home);

    navigationService.navigateTo(routeBuild(userDetailPage!));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
