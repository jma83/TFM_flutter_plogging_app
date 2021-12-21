import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/search_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchRouteCoordinator extends ParentRouteCoordinator {
  RouteDetailPage? routeDetailPage;
  UserDetailPage? userDetailPage;
  SearchRouteCoordinator(
      SearchPage mainWidget, NavigationService navigationService)
      : super(mainWidget, navigationService) {
    mainWidget.viewModel.addListener(
        () => navigateToUserDetail(mainWidget.viewModel.selectedUser),
        [SearchNotifiers.navigateToAuthor]);
  }

  navigateToUserDetail(UserData userData) async {
    userDetailPage = genericNavigateToUser(userData, navigateToRoute);

    routeDetailPage = null;
    navigationService.setCurrentHomeTabItem(TabItem.search);

    navigationService.navigateTo(routeBuild(userDetailPage!));
  }

  navigateToRoute() {}
}
