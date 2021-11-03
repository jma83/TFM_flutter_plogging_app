import 'package:flutter_plogging/src/core/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartRouteCoordinator extends ParentRouteCoordinator {
  StartRouteCoordinator(StartPage mainWidget, navigationService)
      : super(mainWidget, navigationService) {
    print("StartRouteCoordinator!");
    mainWidget.viewModel.addListener(
        () => navigateToHome(), ["startRouteCoordinator_navigateToHome"]);
    mainWidget.viewModel.addListener(
        () => navigateToLogin(), ["startRouteCoordinator_navigateToLogin"]);
    mainWidget.viewModel.addListener(
        () => returnToPrevious(), ["startRouteCoordinator_returnToPrevious"]);
  }

  navigateToHome() {
    print("to home!");
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<MainRouteCoordinator>().mainWidget));
  }

  navigateToLogin() {
    print("to login!");
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<LoginRouteCoordinator>().mainWidget));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
