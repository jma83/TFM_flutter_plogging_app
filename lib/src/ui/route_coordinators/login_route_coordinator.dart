import 'package:flutter_plogging/src/core/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator(LoginPage mainWidget, navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(() => navigateToRegister(),
        ["loginRouteCoordinator_navigateToRegister"]);
    mainWidget.viewModel.addListener(
        () => navigateToHome(), ["loginRouteCoordinator_navigateToHome"]);
    mainWidget.viewModel.addListener(
        () => goBack(), ["loginRouteCoordinator_returnToPrevious"]);
  }

  navigateToHome() {
    print("to home!");
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<MainRouteCoordinator>().mainWidget));
  }

  navigateToRegister() {
    final RegisterPage widget =
        navigationService.getRouteWidget(Ruta.Register) as RegisterPage;
    widget.viewModel.addListener(
        () => goBack(), ["registerRouteCoordinator_returnToPrevious"]);
    widget.viewModel.addListener(() {
      goBack();
      navigateToHome();
    }, ["registerRouteCoordinator_navigateToHome"]);
    navigationService.navigateTo(routeBuild(widget));
  }
}
