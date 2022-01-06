import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/edit_profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/liked_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/profile_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/edit_profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/liked_routes_page.dart';
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
    mainWidget.viewModel.addListener(
        navigateToLikedRoutes, [ProfileNotifiers.navigateToLikedRoutes]);

    viewModels.add(mainWidget.viewModel);
  }

  navigateToEditProfile() {
    final EditProfilePage widget =
        navigationService.getRouteWidget(Ruta.EditProfile) as EditProfilePage;
    widget.viewModel
        .addListener(goBack, [EditProfileNotifiers.navigateToPrevious]);
    widget.viewModel
        .addListener(updateRoute, [EditProfileNotifiers.updateProfileData]);
    navigationService.navigateTo(routeBuild(widget));
  }

  navigateToLikedRoutes() {
    final LikedRoutesPage widget =
        navigationService.getRouteWidget(Ruta.LikedRoutes) as LikedRoutesPage;
    widget.viewModel.addListener(() {
      viewModels.add(widget.viewModel);
      navigateToRoute(
          widget.viewModel.selectedRoute, widget.viewModel.selectedUser);
    }, [LikedRoutesNotifiers.navigateToRoute]);
    widget.viewModel
        .addListener(returnToPrevious, [LikedRoutesNotifiers.returnToPrevious]);
    navigationService.navigateTo(routeBuild(widget));
  }

  navigateToRoute(RouteListData routeListData, UserSearchData userData) {
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }
}
