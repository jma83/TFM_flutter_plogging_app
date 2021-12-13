import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPloggingRouteCoordinator extends ParentRouteCoordinator {
  StartPloggingRouteCoordinator(
      StartPloggingPage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    navigationService.setCurrentHomeTabItem(TabItem.plogging);

    mainWidget.viewModel.addListener(() => returnToPrevious(),
        ["startPloggingRouteCoordinator_returnToPrevious"]);
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
