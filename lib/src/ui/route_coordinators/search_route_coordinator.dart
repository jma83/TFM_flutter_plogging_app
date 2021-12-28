import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
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
  SearchRouteCoordinator(
      SearchPage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(
        () => navigateToUserDetail(mainWidget.viewModel.selectedUser),
        [SearchNotifiers.navigateToAuthor]);
  }

  @override
  updateRoute() {
    viewModels.forEach((element) => element.loadPage());
    (mainWidget as SearchPage).viewModel.loadPage();
  }

  @override
  updatePageData(RouteListAuthorSearchData data) {
    viewModels.forEach((element) {
      element.updateData(data);
    });
    (mainWidget as SearchPage).viewModel.updateData(data);
  }

  navigateToUserDetail(UserData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }

  navigateToRoute(RouteListData routeListData, UserData userData) {
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }
}
