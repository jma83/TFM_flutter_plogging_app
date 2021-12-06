import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';

class InputButtonFollow extends StatefulWidget {
  bool following;
  final double width;
  final Function followCallback;
  InputButtonFollow(
      {required this.following,
      required this.followCallback,
      this.width = 130,
      Key? key})
      : super(key: key);

  @override
  _InputButtonFollowState createState() => _InputButtonFollowState();
}

class _InputButtonFollowState extends State<InputButtonFollow> {
  @override
  Widget build(BuildContext context) {
    if (!widget.following) {
      return InputButton(
          width: widget.width,
          label: const Text("Follow"),
          onPress: () => buttonClick(),
          buttonType: InputButtonType.outlined,
          horizontalPadding: 10);
    }
    return InputButton(
        width: widget.width,
        label: const Text("Following"),
        onPress: () => buttonClick(),
        buttonType: InputButtonType.elevated,
        bgColor: Colors.blue,
        horizontalPadding: 10);
  }

  buttonClick() {
    setState(() => widget.following = !widget.following);
    widget.followCallback();
  }
}
