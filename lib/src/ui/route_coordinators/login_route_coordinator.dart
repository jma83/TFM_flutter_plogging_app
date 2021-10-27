import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/pages/register_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginRouteCoordinator extends ParentRouteCoordinator {
  RegisterPage registerPage;
  LoginRouteCoordinator(
      LoginPage mainWidget, navigationService, this.registerPage)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(() => navigateToRegister(),
        ["loginRouteCoordinator_navigateToRegister"]);
    mainWidget.viewModel.addListener(
        () => returnToPrevious(), ["loginRouteCoordinator_returnToPrevious"]);
  }

  navigateToRegister() {
    navigationService.navigateTo(routeBuild(registerPage));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
