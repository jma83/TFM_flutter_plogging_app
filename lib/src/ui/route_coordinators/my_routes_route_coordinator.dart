import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/my_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyRoutesRouteCoordinator extends ParentRouteCoordinator {
  RouteDetailPage? routeDetailPage;
  UserDetailPage? userDetailPage;
  MyRoutesRouteCoordinator(
      MyRoutesPage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(
        () => navigateToRoute(mainWidget.viewModel.selectedRoute,
            mainWidget.viewModel.selectedAuthor),
        [MyRouteNotifiers.navigateToRoute]);
  }

  @override
  updateRoute() {
    (mainWidget as MyRoutesPage).viewModel.updatePage();
    routeDetailPage?.viewModel.updatePage();
    userDetailPage?.viewModel.updatePage();
  }

  navigateToRoute(RouteListData routeListData, UserData userData) {
    MyRoutesPage mainWidgetMyRoutes = mainWidget as MyRoutesPage;
    routeDetailPage = genericNavigateToRoute(
        routeListData,
        userData,
        (userData) => navigateToUserDetail(userData),
        () => mainWidgetMyRoutes.viewModel.updatePage());

    userDetailPage = null;
    navigationService.setCurrentHomeTabItem(TabItem.myRoutes);
    navigationService.navigateTo(routeBuild(routeDetailPage!));
  }

  navigateToUserDetail(UserData userData) async {
    userDetailPage = genericNavigateToUser(userData, navigateToRoute);

    routeDetailPage = null;
    navigationService.setCurrentHomeTabItem(TabItem.myRoutes);

    navigationService.navigateTo(routeBuild(userDetailPage!));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
