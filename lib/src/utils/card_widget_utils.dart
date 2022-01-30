import 'package:flutter/material.dart';

class CardWidgetUtils {
  static Widget createClickableCard(Widget widget, Function? callback) {
    final fun = callback ?? () {};
    return Stack(
      children: [
        widget,
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => fun(),
                ))),
      ],
    );
  }

  static Widget createCardContainer(Widget child, double borderRadius) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(2, 10))
            ]),
        child: ClipRRect(
          child: child,
          borderRadius: BorderRadius.circular(borderRadius),
        ));
  }
}
