import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
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
  HomeRouteCoordinator(HomePage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(
        () => navigateToRoute(mainWidget.viewModel.selectedRoute),
        [HomeNotifiers.navigateToRoute]);
  }

  navigateToRoute(RouteListData routeListData) {
    final RouteDetailPage widget =
        navigationService.getRouteWidget(Ruta.RouteDetail) as RouteDetailPage;
    widget.viewModel.setRoute(routeListData);
    widget.viewModel.addListener(
        () => returnToPrevious(), [HomeNotifiers.returnToPrevious]);
    navigationService.setCurrentHomeTabItem(TabItem.home);

    navigationService.navigateTo(routeBuild(widget));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
