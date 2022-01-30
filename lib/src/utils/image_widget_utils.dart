import 'package:flutter/material.dart';

class ImageWidgetUtils {
  static const defaultRouteImg = "assets/img1.jpg";
  static const secondaryRouteImg = "assets/img2.jpg";
  static const defaultAvatarImg = "assets/logo.png";
  static const defaultPlaceholder = "assets/recycle.gif";
  static const notFoundImg = "assets/not-found.png";
  static final badgeTextDecoration = BoxDecoration(
      color: Colors.yellow[300],
      border: Border.all(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(20));

  static Widget getImageFromNetwork(String imageSrc,
      {bool avatar = false,
      BoxFit fit = BoxFit.contain,
      bool rounded = false,
      double? height,
      double? width}) {
    final String placeholderImg =
        avatar ? defaultAvatarImg : defaultPlaceholder;
    final FadeInImage image = FadeInImage(
      image: NetworkImage(imageSrc),
      height: height,
      width: width,
      placeholder: AssetImage(placeholderImg),
      placeholderErrorBuilder: (context, ob, stack) =>
          Image.asset(defaultRouteImg, fit: fit, height: height, width: width),
      fadeInDuration: const Duration(milliseconds: 200),
      fit: fit,
    );
    return rounded ? getRoundedImage(image) : image;
  }

  static Widget getImageFromAsset(
      {bool avatar = false,
      BoxFit fit = BoxFit.contain,
      bool rounded = false,
      String? imageSrc,
      double? height}) {
    final String imageDefault = avatar ? defaultAvatarImg : defaultRouteImg;
    final FadeInImage image = FadeInImage(
        image: AssetImage(imageSrc ?? imageDefault),
        placeholder: AssetImage(imageDefault),
        height: height,
        fadeInDuration: const Duration(milliseconds: 200),
        fit: fit);
    return rounded ? getRoundedImage(image) : image;
  }

  static getRoundedImage(FadeInImage image) {
    return ClipRRect(borderRadius: BorderRadius.circular(100.0), child: image);
  }
}
