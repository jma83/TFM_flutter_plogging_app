import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';

class InputButtonLike extends StatefulWidget {
  bool liked;
  final double width;
  final Function likeCallback;
  InputButtonLike(
      {required this.liked,
      required this.likeCallback,
      this.width = 130,
      Key? key})
      : super(key: key);

  @override
  _InputButtonLikeState createState() => _InputButtonLikeState();
}

class _InputButtonLikeState extends State<InputButtonLike> {
  @override
  Widget build(BuildContext context) {
    return likeButton();
  }

  likeButton() {
    final icon = widget.liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined;
    return InputButton(
      label: const Text(""),
      icon: Icon(icon),
      horizontalPadding: 0,
      borderRadius: 100,
      width: widget.width,
      verticalPadding: 12,
      onPress: widget.likeCallback,
    );
  }

  buttonClick() {
    setState(() => widget.liked = !widget.liked);
    widget.likeCallback();
  }
}
