import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/route_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/notifiers/user_detail_notifier.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/route_detail_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/user_detail_page.dart';
import 'package:flutter_plogging/src/ui/routes/route_names.dart';

class ParentRouteCoordinator {
  late final Widget mainWidget;
  late final NavigationService navigationService;

  ParentRouteCoordinator(this.mainWidget, this.navigationService);

  Widget getAndUpdateWidget() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      updateRoute();
    });
    return mainWidget;
  }

  updateRoute() {
    // implements in child
  }

  RouteDetailPage genericNavigateToRoute(RouteListData routeListData,
      UserData userData, Function navigateToUserDetail, Function updatePage) {
    RouteDetailPage newRouteDetailPage =
        navigationService.getRouteWidget(Ruta.RouteDetail) as RouteDetailPage;
    newRouteDetailPage.viewModel.setRouteAndAuthor(routeListData, userData);
    newRouteDetailPage.viewModel.addListener(
        () => navigateToUserDetail(userData),
        [RouteDetailNotifier.navigateToAuthor]);
    newRouteDetailPage.viewModel
        .addListener(() => updatePage(), [RouteDetailNotifier.updatePage]);

    return newRouteDetailPage;
  }

  UserDetailPage genericNavigateToUser(
      UserData userData, Function navigateToRoute) {
    UserDetailPage nextUserDetailPage =
        navigationService.getRouteWidget(Ruta.UserDetail) as UserDetailPage;
    nextUserDetailPage.viewModel.setUserData(userData);

    nextUserDetailPage.viewModel.addListener(
        () => navigateToRoute(
            nextUserDetailPage.viewModel.selectedRoute, userData),
        [UserDetailNotifier.navigateToRoute]);
    return nextUserDetailPage;
  }

  routeBuild(Widget widgetRoute) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widgetRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
