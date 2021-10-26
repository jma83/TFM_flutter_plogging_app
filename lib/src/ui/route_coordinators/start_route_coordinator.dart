import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/src/property_change_notifier.dart';

@injectable
class StartRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator loginRouteCoordinator;

  StartRouteCoordinator(
      mainWidget, viewModel, navigationService, this.loginRouteCoordinator)
      : super(mainWidget, viewModel, navigationService) {
    print("crea!");
    viewModel.addListener(
        () => navigateToHome(), ["startRouteCoordinator_navigateToHome"]);
    viewModel.addListener(
        () => navigateToLogin(), ["startRouteCoordinator_navigateToLogin"]);
    viewModel.addListener(
        () => returnToPrevious(), ["startRouteCoordinator_returnToPrevious"]);
  }

  navigateToHome() {
    print("to home!");
    final homePage = navigationService.getRouteWidget(Ruta.Home.getValue());
    navigationService.navigateAndReplaceToByName(routeBuild(homePage!));
  }

  navigateToLogin() {
    print("to login!");
    final loginPage = navigationService.getRouteWidget(Ruta.Login.getValue());
    navigationService.navigateAndReplaceToByName(routeBuild(loginPage!));
  }

  returnToPrevious() {
    navigationService.goBack();
  }
}
