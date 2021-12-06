import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';

class InputButtonLike extends StatefulWidget {
  bool liked;
  bool isSelf;
  final double width;
  final Function likeCallback;
  InputButtonLike(
      {required this.liked,
      required this.likeCallback,
      this.width = 130,
      this.isSelf = false,
      Key? key})
      : super(key: key);

  @override
  _InputButtonLikeState createState() => _InputButtonLikeState();
}

class _InputButtonLikeState extends State<InputButtonLike> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSelf) {
      return Container();
    }
    if (!widget.liked) {
      return InputButton(
        label: Text(""),
        icon: Icon(Icons.thumb_up_alt_outlined),
        horizontalPadding: 0,
        borderRadius: 100,
        width: 0,
        verticalPadding: 12,
        onPress: () {},
      );
    }
    return InputButton(
      label: Text(""),
      icon: Icon(Icons.thumb_up),
      horizontalPadding: 0,
      borderRadius: 100,
      width: 0,
      verticalPadding: 12,
      onPress: () {},
    );
  }

  buttonClick() {
    setState(() => widget.liked = !widget.liked);
    widget.likeCallback();
  }
}
