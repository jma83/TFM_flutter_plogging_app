import 'package:flutter/material.dart';

enum InputButtonType { elevated, outlined }

class InputButton extends StatefulWidget {
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
          style: btnStyleOutlined);
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
    return ElevatedButton.styleFrom(
        primary: widget.bgColor ?? Colors.green,
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding,
            vertical: widget.verticalPadding),
        fixedSize: Size.fromWidth(widget.width));
  }

  ButtonStyle get btnStyleOutlined {
    return OutlinedButton.styleFrom(
        backgroundColor: widget.bgColor ?? Colors.white70,
        side: const BorderSide(width: 1, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding,
            vertical: widget.verticalPadding),
        fixedSize: Size.fromWidth(widget.width));
  }
}
