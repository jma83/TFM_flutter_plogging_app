import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';

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
