import 'package:flutter/material.dart';

final btnStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
    fixedSize: const Size.fromWidth(200));

class Button {
  static Widget createButtonWithIcon(
      int buttonType, final onPress, Widget label, Icon icon) {
    if (buttonType == 1) {
      return OutlinedButton.icon(
          onPressed: onPress, icon: icon, label: label, style: btnStyle);
    }
    return ElevatedButton.icon(
        onPressed: onPress, icon: icon, label: label, style: btnStyle);
  }

  static Widget createButton(
      int buttonType, final onPress, Widget child, Icon icon) {
    if (buttonType == 1) {
      return OutlinedButton(onPressed: onPress, child: child, style: btnStyle);
    }
    return ElevatedButton(onPressed: onPress, child: child, style: btnStyle);
  }
}
