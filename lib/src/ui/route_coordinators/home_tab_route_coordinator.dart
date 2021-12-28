import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/notifiers/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/ui/tabs/home_navigation_keys.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_tabs_change_notifier.dart';

class HomeTabRouteCoordinator extends ParentRouteCoordinator {
  final TabItem? tabItem;
  List<HomeTabsChangeNotifier> viewModels = [];
  HomeTabRouteCoordinator(mainWidget, navigationService, this.tabItem)
      : super(mainWidget, navigationService);

  Widget getAndUpdateWidget() {
    if (navigationService.currentHomeTabItem == tabItem) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        updateRoute();
      });
    }
    return mainWidget;
  }

  updateRoute() {
    for (var element in viewModels) {
      element.loadPage();
    }
  }

  updatePageData(RouteListAuthorSearchData data) {
    for (var element in viewModels) {
      if (viewModels.last != element) {
        element.updateData(data);
      }
    }
  }

  void genericNavigateToRoute(RouteListData routeListData,
      UserSearchData userData, Function navigateToUserDetail) {
    RouteDetailPage newRouteDetailPage =
        navigationService.getRouteWidget(Ruta.RouteDetail) as RouteDetailPage;
    newRouteDetailPage.viewModel.setRouteAndAuthor(routeListData, userData);
    newRouteDetailPage.viewModel.addListener(() {
      navigateToUserDetail(userData);
    }, [RouteDetailNotifier.navigateToAuthor]);
    newRouteDetailPage.viewModel.addListener(
        () => updatePageData(RouteListAuthorSearchData(
            newRouteDetailPage.viewModel.route, null)),
        [RouteDetailNotifier.updateData]);

    viewModels.add(newRouteDetailPage.viewModel);
    navigationService.setCurrentHomeTabItem(tabItem);
    navigationService.navigateTo(routeBuild(newRouteDetailPage));
  }

  void genericNavigateToUser(
      UserSearchData userData, Function navigateToRoute) {
    UserDetailPage nextUserDetailPage =
        navigationService.getRouteWidget(Ruta.UserDetail) as UserDetailPage;
    nextUserDetailPage.viewModel.setUserData(userData);

    nextUserDetailPage.viewModel.addListener(() {
      navigateToRoute(nextUserDetailPage.viewModel.selectedRoute, userData);
    }, [UserDetailNotifier.navigateToRoute]);
    nextUserDetailPage.viewModel.addListener(
        () => updatePageData(RouteListAuthorSearchData(
            nextUserDetailPage.viewModel.selectedRoute,
            nextUserDetailPage.viewModel.user)),
        [UserDetailNotifier.updateData]);

    viewModels.add(nextUserDetailPage.viewModel);
    navigationService.setCurrentHomeTabItem(tabItem);
    navigationService.navigateTo(routeBuild(nextUserDetailPage));
  }

  Future<bool> returnToPrevious() async {
    // viewModels.removeLast();
    final bool result =
        !await navigationService.currentNavigator.currentState!.maybePop();
    return result;
  }
}
