import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';

class ParentRouteCoordinator {
  final Widget mainWidget;
  final NavigationService navigationService;

  ParentRouteCoordinator(this.mainWidget, this.navigationService);

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

  void goBack() {
    print("elpepe");
    navigationService.goBack();
  }
}
