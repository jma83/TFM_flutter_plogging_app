import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/services/navigation_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class ParentPageRouteCoordinator {
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
