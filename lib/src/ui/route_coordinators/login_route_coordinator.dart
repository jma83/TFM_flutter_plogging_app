import 'package:flutter_plogging/src/core/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/routes/routes.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator(LoginPage mainWidget, navigationService)
      : super(mainWidget, navigationService) {
    print("LoginRouteCoordinator");
    mainWidget.viewModel.addListener(() => navigateToRegister(),
        ["loginRouteCoordinator_navigateToRegister"]);
    mainWidget.viewModel.addListener(
        () => returnToPrevious(), ["loginRouteCoordinator_returnToPrevious"]);
  }

  navigateToRegister() {
    final widget = navigationService.getRouteWidget(Ruta.Register.getValue());
    navigationService.navigateTo(routeBuild(widget!));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
