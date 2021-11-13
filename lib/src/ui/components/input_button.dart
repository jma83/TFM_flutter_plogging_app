import 'package:flutter/material.dart';

enum InputButtonType { elevated, outlined }

final btnStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
    fixedSize: const Size.fromWidth(170));

class InputButton extends StatefulWidget {
  InputButtonType buttonType;
  Function onPress;
  Widget label;
  Icon? icon;

  InputButton(
      {required this.label,
      required this.onPress,
      this.buttonType = InputButtonType.elevated,
      this.icon,
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
          style: btnStyle);
    }
    return ElevatedButton(
        onPressed: () => widget.onPress(),
        child: widget.label,
        style: btnStyle);
  }
}
