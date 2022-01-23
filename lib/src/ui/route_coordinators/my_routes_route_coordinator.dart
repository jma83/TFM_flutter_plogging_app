import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/my_routes_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/my_routes_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page_view.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/my_routes_page_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyRoutesRouteCoordinator extends HomeTabRouteCoordinator {
  RouteDetailPageView? routeDetailPage;
  UserDetailPageView? userDetailPage;
  MyRoutesRouteCoordinator(MyRoutesPageView mainWidget,
      NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    MyRoutesPageViewModel viewModel =
        mainWidget.viewModel as MyRoutesPageViewModel;
    mainWidget.viewModel.addListener(
        () =>
            navigateToRoute(viewModel.selectedRoute, viewModel.selectedAuthor),
        [MyRouteNotifiers.navigateToRoute]);
    mainWidget.viewModel.addListener(
        () => returnToPrevious(), [MyRouteNotifiers.returnToPrevious]);
    viewModels.add(mainWidget.viewModel as HomeTabsChangeNotifier);
  }

  navigateToRoute(RouteListData routeListData, UserSearchData userData) {
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }
}
