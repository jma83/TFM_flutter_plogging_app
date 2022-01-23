import 'package:flutter_plogging/src/di/container.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/home_tabs_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_tab_bar.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tab_bar_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainRouteCoordinator extends ParentRouteCoordinator {
  MainRouteCoordinator(
      HomeTabBar mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel
        .addListener(navigateToLogin, [HomeTabsNotifiers.homeTabsLogout]);
    mainWidget.viewModel
        .addListener(instanceHomeTab, [HomeTabsNotifiers.instanceHomeTab]);
  }

  navigateToLogin() {
    navigationService.setCurrentHomeTabItem(null);
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<LoginRouteCoordinator>().mainWidget));
  }

  instanceHomeTab() {
    HomeTabBar myWidget = mainWidget as HomeTabBar;
    HomeTabBarViewModel viewModel = myWidget.viewModel as HomeTabBarViewModel;
    HomeTabsChangeNotifier homeTabsChangeNotifier =
        viewModel.getViewModel(navigationService.currentHomeTabItem!);
    homeTabsChangeNotifier.addListener(
        () => manageNavigation(homeTabsChangeNotifier.nextTabItem),
        [HomeTabsNotifiers.redirectHomeTabNavigation]);
  }

  manageNavigation(TabItem? tabItem) {
    if (tabItem != null) {
      navigationService.setCurrentHomeTabItem(tabItem);
    }
  }
}
