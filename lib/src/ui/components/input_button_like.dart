import 'package:flutter/material.dart';

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
    return FloatingActionButton(
        onPressed: () => widget.likeCallback(), child: Icon(icon));
  }

  buttonClick() {
    setState(() => widget.liked = !widget.liked);
    widget.likeCallback();
  }
}
