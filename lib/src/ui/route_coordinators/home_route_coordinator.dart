import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRouteCoordinator extends ParentRouteCoordinator {
  RouteDetailPage? routeDetailPage;
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
  }

  navigateToRoute(RouteListData routeListData, UserData userData) async {
    final HomePage mainWidgetHome = mainWidget as HomePage;
    routeDetailPage =
        navigationService.getRouteWidget(Ruta.RouteDetail) as RouteDetailPage;
    await routeDetailPage!.viewModel.setRouteAndAuthor(routeListData, userData);
    routeDetailPage!.viewModel.addListener(
        () => returnToPrevious(), [HomeNotifiers.returnToPrevious]);
    routeDetailPage!.viewModel.addListener(
        () => mainWidgetHome.viewModel.updatePage(),
        [HomeNotifiers.updateHomePage]);
    navigationService.setCurrentHomeTabItem(TabItem.home);

    navigationService.navigateTo(routeBuild(routeDetailPage!));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
