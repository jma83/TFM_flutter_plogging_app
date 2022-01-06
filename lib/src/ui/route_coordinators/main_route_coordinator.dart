import 'package:flutter_plogging/src/core/di/entities/application.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainRouteCoordinator extends ParentRouteCoordinator {
  MainRouteCoordinator(
      HomeTabBar mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel
        .addListener(navigateToLogin, [HomeTabsNotifiers.homeTabsLogout]);
  }

  navigateToLogin() {
    navigationService.setCurrentHomeTabItem(null);
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<LoginRouteCoordinator>().mainWidget));
  }
}
