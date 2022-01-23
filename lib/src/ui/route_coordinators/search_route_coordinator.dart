import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/search_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/search_page_view.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/search_page_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchRouteCoordinator extends HomeTabRouteCoordinator {
  SearchRouteCoordinator(SearchPageView mainWidget,
      NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    SearchPageViewModel viewModel = mainWidget.viewModel as SearchPageViewModel;
    viewModel.addListener(() => navigateToUserDetail(viewModel.selectedUser),
        [SearchNotifiers.navigateToAuthor]);
    viewModel.addListener(
        () => returnToPrevious(), [SearchNotifiers.navigateToPrevious]);
    viewModels.add(mainWidget.viewModel as HomeTabsChangeNotifier);
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }

  navigateToRoute(RouteListData routeListData, UserSearchData userData) {
    genericNavigateToRoute(routeListData, userData, navigateToUserDetail);
  }
}
