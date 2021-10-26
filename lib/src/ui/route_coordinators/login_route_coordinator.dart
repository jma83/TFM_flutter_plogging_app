import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/login_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/src/property_change_notifier.dart';

@injectable
class LoginRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator(LoginPage mainWidget, navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(
        () => navigateToHome(), ["loginRouteCoordinator_navigateToHome"]);
    mainWidget.viewModel.addListener(
        () => navigateToHome(), ["loginRouteCoordinator_navigateToLogin"]);
    mainWidget.viewModel.addListener(
        () => returnToPrevious(), ["loginRouteCoordinator_returnToPrevious"]);
  }

  navigateToRegister() {
    final registerPage = navigationService.getRouteWidget(Ruta.Home.getValue());
    navigationService.navigateAndReplaceTo(routeBuild(registerPage!));
  }

  navigateToHome() {
    final homePage = navigationService.getRouteWidget(Ruta.Home.getValue());
    navigationService.navigateAndReplaceTo(routeBuild(homePage!));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
