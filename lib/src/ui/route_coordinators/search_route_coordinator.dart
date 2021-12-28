import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/search_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchRouteCoordinator extends HomeTabRouteCoordinator {
  SearchRouteCoordinator(
      SearchPage mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    mainWidget.viewModel.addListener(
        () => navigateToUserDetail(mainWidget.viewModel.selectedUser),
        [SearchNotifiers.navigateToAuthor]);
    mainWidget.viewModel.addListener(
        () => returnToPrevious(), [SearchNotifiers.navigateToPrevious]);
    viewModels.add(mainWidget.viewModel);
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }

  navigateToRoute(RouteListData routeListData, UserSearchData userData) {
    genericNavigateToRoute(routeListData, userData, navigateToUserDetail);
  }
}
