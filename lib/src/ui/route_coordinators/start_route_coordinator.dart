import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator loginRouteCoordinator;
  MainRouteCoordinator mainRouteCoordinator;

  StartRouteCoordinator(StartPage mainWidget, navigationService,
      this.loginRouteCoordinator, this.mainRouteCoordinator)
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
    navigationService
        .navigateAndReplaceTo(routeBuild(mainRouteCoordinator.mainWidget));
  }

  navigateToLogin() {
    print("to login!");
    navigationService
        .navigateAndReplaceTo(routeBuild(loginRouteCoordinator.mainWidget));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
