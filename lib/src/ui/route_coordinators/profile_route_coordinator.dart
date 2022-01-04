import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/profile_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileRouteCoordinator extends HomeTabRouteCoordinator {
  ProfileRouteCoordinator(
      ProfilePage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(goBack, [ProfileNotifiers.goBackDismiss]);
    mainWidget.viewModel.addListener(
        navigateToEditProfile, [ProfileNotifiers.navigateToEditProfile]);

    viewModels.add(mainWidget.viewModel);
  }

  navigateToEditProfile() {
    final Widget widget = navigationService.getRouteWidget(Ruta.EditProfile);
    navigationService.navigateTo(routeBuild(widget));
  }
}
