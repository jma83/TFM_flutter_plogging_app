import 'package:flutter/material.dart';

enum InputButtonType { elevated, outlined }

class InputButton extends StatefulWidget {
  InputButtonType buttonType;
  Function onPress;
  Widget label;
  Icon? icon;
  double width;
  double horizontalPadding;

  InputButton(
      {required this.label,
      required this.onPress,
      this.buttonType = InputButtonType.elevated,
      this.icon,
      this.horizontalPadding = 40,
      this.width = 170,
      Key? key})
      : super(key: key);

  @override
  _InputButtonState createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
  @override
  Widget build(BuildContext context) {
    return widget.icon == null ? createButton() : createButtonWithIcon();
  }

  Widget createButtonWithIcon() {
    if (widget.buttonType == InputButtonType.outlined) {
      return OutlinedButton.icon(
          onPressed: () => widget.onPress(),
          icon: widget.icon!,
          label: widget.label,
          style: btnStyle);
    }
    return ElevatedButton.icon(
        onPressed: () => widget.onPress(),
        icon: widget.icon!,
        label: widget.label,
        style: btnStyle);
  }

  Widget createButton() {
    if (widget.buttonType == InputButtonType.outlined) {
      return OutlinedButton(
          onPressed: () => widget.onPress(),
          child: widget.label,
          style: btnStyleOutlined);
    }
    return ElevatedButton(
        onPressed: () => widget.onPress(),
        child: widget.label,
        style: btnStyle);
  }

  ButtonStyle get btnStyle {
    return OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding, vertical: 8),
        fixedSize: Size.fromWidth(widget.width));
  }

  ButtonStyle get btnStyleOutlined {
    return OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding, vertical: 8),
        fixedSize: Size.fromWidth(widget.width));
  }
}
