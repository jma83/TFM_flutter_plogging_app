import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_author_search_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/notifiers/home_tabs/shared/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/shared/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/parent_route_coordinator.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';
import 'package:flutter_plogging/src/core/domain/tabs/tab_item_data.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/parent/home_tabs_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/route_detail_page_viewmodel.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/shared/user_detail_page_view_model.dart';

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
    RouteDetailPageViewModel viewModel =
        newRouteDetailPage.viewModel as RouteDetailPageViewModel;

    viewModel.setRouteAndAuthor(routeListData, userData);
    viewModel.addListener(() {
      navigateToUserDetail(userData);
    }, [RouteDetailNotifier.navigateToAuthor]);
    newRouteDetailPage.viewModel.addListener(
        () => returnToPrevious(), [RouteDetailNotifier.navigateToPrevious]);
    newRouteDetailPage.viewModel.addListener(
        () => updatePageData(RouteListAuthorSearchData(viewModel.route, null)),
        [RouteDetailNotifier.updateData]);

    viewModels.add(newRouteDetailPage.viewModel as HomeTabsChangeNotifier);
    navigationService.setCurrentHomeTabItem(tabItem);
    navigationService.navigateTo(routeBuild(newRouteDetailPage));
  }

  void genericNavigateToUser(
      UserSearchData userData, Function navigateToRoute) {
    UserDetailPage nextUserDetailPage =
        navigationService.getRouteWidget(Ruta.UserDetail) as UserDetailPage;
    UserDetailPageViewModel viewModel =
        nextUserDetailPage.viewModel as UserDetailPageViewModel;
    viewModel.setUserData(userData);

    nextUserDetailPage.viewModel.addListener(() {
      navigateToRoute(viewModel.selectedRoute, userData);
    }, [UserDetailNotifier.navigateToRoute]);
    nextUserDetailPage.viewModel.addListener(
        () => returnToPrevious(), [UserDetailNotifier.navigateToPrevious]);
    nextUserDetailPage.viewModel.addListener(
        () => updatePageData(
            RouteListAuthorSearchData(viewModel.selectedRoute, viewModel.user)),
        [UserDetailNotifier.updateData]);

    viewModels.add(nextUserDetailPage.viewModel as HomeTabsChangeNotifier);
    navigationService.setCurrentHomeTabItem(tabItem);
    navigationService.navigateTo(routeBuild(nextUserDetailPage));
  }

  Future<bool> returnToPrevious() async {
    if (viewModels.isNotEmpty) {
      viewModels.removeLast();
    }
    final bool result =
        !await navigationService.currentNavigator.currentState!.maybePop();
    return result;
  }
}
