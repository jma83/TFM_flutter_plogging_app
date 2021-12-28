import 'package:flutter_plogging/src/core/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileRouteCoordinator extends HomeTabRouteCoordinator {
  ProfileRouteCoordinator(
      ProfilePage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(
        navigateToLogin, ["profileRouteCoordinator_navigateToLogin"]);

    // viewModels.add(mainWidget.viewModel);
  }

  navigateToLogin() {
    navigationService.setCurrentHomeTabItem(null);
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<LoginRouteCoordinator>().mainWidget));
  }
}
