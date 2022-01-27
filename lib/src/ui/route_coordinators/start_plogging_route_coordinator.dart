import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/start_plogging_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/start_plogging_page_view.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPloggingRouteCoordinator extends HomeTabRouteCoordinator {
  StartPloggingRouteCoordinator(StartPloggingPageView mainWidget,
      NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel
        .addListener(() => goBack(), [StartPloggingNotifiers.returnToPrevious]);
  }
}
