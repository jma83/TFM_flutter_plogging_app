import 'package:flutter_plogging/src/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/ui/notifiers/start_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartRouteCoordinator extends ParentRouteCoordinator {
  StartRouteCoordinator(StartPage mainWidget, navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel
        .addListener(() => navigateToHome(), [StartNotifiers.navigateToHome]);
    mainWidget.viewModel
        .addListener(() => navigateToLogin(), [StartNotifiers.navigateToLogin]);
  }

  navigateToHome() {
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<MainRouteCoordinator>().mainWidget));
  }

  navigateToLogin() {
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<LoginRouteCoordinator>().mainWidget));
  }
}
