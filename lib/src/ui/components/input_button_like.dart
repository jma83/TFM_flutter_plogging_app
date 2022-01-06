import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputButtonLike extends StatefulWidget {
  final String id;
  bool liked;
  final Function likeCallback;
  InputButtonLike(
      {required this.id,
      required this.liked,
      required this.likeCallback,
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
        heroTag: "like_${widget.id}",
        onPressed: () => widget.likeCallback(),
        child: Icon(icon));
  }

  buttonClick() {
    setState(() => widget.liked = !widget.liked);
    widget.likeCallback();
  }
}
