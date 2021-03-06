import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/how_it_works_notifiers.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/tabs/home_notifiers.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/how_it_works_page_view.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/tabs/home_page_view.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/home_tab_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/how_it_works_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/tabs/home_page_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRouteCoordinator extends HomeTabRouteCoordinator {
  HomeRouteCoordinator(
      HomePageView mainWidget, NavigationService navigationService, tabBarItem)
      : super(mainWidget, navigationService, tabBarItem) {
    HomePageViewModel viewModel = mainWidget.viewModel as HomePageViewModel;
    viewModel.addListener(
        () =>
            navigateToRoute(viewModel.selectedRoute, viewModel.selectedAuthor),
        [HomeNotifiers.navigateToRoute]);
    viewModel.addListener(
        () => navigateToHowItWorks(), [HomeNotifiers.navigateToHowItWorks]);

    viewModels.add(mainWidget.viewModel as HomeTabsChangeNotifier);
  }

  navigateToHowItWorks() {
    HowItWorksPageView howItWorksPage =
        navigationService.getRouteWidget(Ruta.HowItWorks) as HowItWorksPageView;
    howItWorksPage.viewModel.addListener(
        () => returnToPrevious(), [HowItWorksNotifiers.navigateToPrevious]);
    viewModels.add(howItWorksPage.viewModel as HowItWorksPageViewModel);
    navigationService.navigateTo(routeBuild(howItWorksPage));
  }

  navigateToRoute(RouteListData? routeListData, UserSearchData? userData) {
    if (routeListData == null || userData == null) return;
    genericNavigateToRoute(
        routeListData, userData, (userData) => navigateToUserDetail(userData));
  }

  navigateToUserDetail(UserSearchData userData) async {
    genericNavigateToUser(userData, navigateToRoute);
  }
}
