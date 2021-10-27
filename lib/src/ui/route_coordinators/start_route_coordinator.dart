import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/pages/start_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/main_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/view_models/start_page/start_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/src/property_change_notifier.dart';

@injectable
class StartRouteCoordinator extends ParentRouteCoordinator {
  LoginRouteCoordinator loginRouteCoordinator;
  MainRouteCoordinator mainRouteCoordinator;

  StartRouteCoordinator(StartPage mainWidget, navigationService,
      this.loginRouteCoordinator, this.mainRouteCoordinator)
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
    navigationService
        .navigateAndReplaceTo(routeBuild(loginRouteCoordinator.mainWidget));
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
