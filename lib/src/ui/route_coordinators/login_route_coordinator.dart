import 'package:flutter_plogging/src/di/container.dart';
import 'package:flutter_plogging/src/ui/notifiers/login_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/register_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/login_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/register_page_view.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator(LoginPageView mainWidget, navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(
        () => navigateToRegister(), [LoginNotifiers.navigateToRegister]);
    mainWidget.viewModel
        .addListener(() => navigateToHome(), [LoginNotifiers.navigateToHome]);
    mainWidget.viewModel
        .addListener(() => goBack(), [LoginNotifiers.navigateToPrevious]);
  }

  navigateToHome() {
    navigationService.navigateAndReplaceTo(
        routeBuild(getIt<MainRouteCoordinator>().mainWidget));
  }

  navigateToRegister() {
    final RegisterPageView widget =
        navigationService.getRouteWidget(Ruta.Register) as RegisterPageView;
    widget.viewModel
        .addListener(() => goBack(), [RegisterNotifiers.navigateToPrevious]);
    widget.viewModel.addListener(() {
      goBack();
      navigateToHome();
    }, [RegisterNotifiers.navigateToHome]);
    navigationService.navigateTo(routeBuild(widget));
  }
}
