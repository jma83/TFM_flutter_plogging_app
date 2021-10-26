import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/src/property_change_notifier.dart';

@injectable
class StartRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator loginRouteCoordinator;

  StartRouteCoordinator(
      StartPage mainWidget, navigationService, this.loginRouteCoordinator)
      : super(mainWidget, navigationService) {
    print("crea!");
    mainWidget.viewModel.addListener(
        () => navigateToHome(), ["startRouteCoordinator_navigateToHome"]);
    mainWidget.viewModel.addListener(
        () => navigateToLogin(), ["startRouteCoordinator_navigateToLogin"]);
    mainWidget.viewModel.addListener(
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
