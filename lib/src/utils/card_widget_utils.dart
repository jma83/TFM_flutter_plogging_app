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

  static getImageFromNetwork(String image,
      {bool avatar = false, BoxFit fit = BoxFit.contain, double? height}) {
    final String placeholderImg =
        avatar ? "assets/logo.png" : "assets/img1.jpg";

    return FadeInImage.assetNetwork(
      image: image,
      height: height,
      placeholder: placeholderImg,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: fit,
    );
  }

  static getImageFromAsset(
      {bool avatar = false, BoxFit fit = BoxFit.contain, double? height}) {
    final String image = avatar ? "assets/logo.png" : "assets/img1.jpg";
    return FadeInImage(
        image: AssetImage(image),
        placeholder: AssetImage(image),
        height: height,
        fadeInDuration: const Duration(milliseconds: 200),
        fit: fit);
  }
}
