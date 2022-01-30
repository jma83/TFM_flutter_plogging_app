import 'package:flutter/material.dart';

enum InputButtonType { elevated, outlined }

class InputButton extends StatelessWidget {
  final InputButtonType buttonType;
  final Function onPress;
  final Widget label;
  final Icon? icon;
  final double width;
  final double verticalPadding;
  final double horizontalPadding;
  final Color? bgColor;
  final double borderRadius;

  const InputButton(
      {required this.label,
      required this.onPress,
      this.bgColor,
      this.buttonType = InputButtonType.elevated,
      this.icon,
      this.horizontalPadding = 40,
      this.width = 170,
      this.verticalPadding = 8,
      this.borderRadius = 20,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null ? createButton() : createButtonWithIcon();
  }

  Widget createButtonWithIcon() {
    if (buttonType == InputButtonType.outlined) {
      return OutlinedButton.icon(
          onPressed: () => onPress(),
          icon: icon!,
          label: label,
          style: btnStyleOutlined);
    }
    return ElevatedButton.icon(
        onPressed: () => onPress(), icon: icon!, label: label, style: btnStyle);
  }

  Widget createButton() {
    if (buttonType == InputButtonType.outlined) {
      return OutlinedButton(
          onPressed: () => onPress(), child: label, style: btnStyleOutlined);
    }
    return ElevatedButton(
        onPressed: () => onPress(), child: label, style: btnStyle);
  }

  ButtonStyle get btnStyle {
    return ElevatedButton.styleFrom(
        primary: bgColor ?? Colors.green,
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        fixedSize: Size.fromWidth(width));
  }

  ButtonStyle get btnStyleOutlined {
    return OutlinedButton.styleFrom(
        backgroundColor: bgColor ?? Colors.white70,
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        fixedSize: Size.fromWidth(width));
  }
}
