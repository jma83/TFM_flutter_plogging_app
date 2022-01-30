import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/utils/toast_utils.dart';

class InputButtonLike extends StatelessWidget {
  final String id;
  final bool liked;
  final Function likeCallback;
  const InputButtonLike(
      {required this.id,
      required this.liked,
      required this.likeCallback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined;
    return FloatingActionButton(
        heroTag: "like_$id",
        onPressed: () => buttonClick(context),
        child: Icon(icon));
  }

  buttonClick(BuildContext context) {
    _showToast(context);
    likeCallback();
  }

  void _showToast(BuildContext context) {
    final String message =
        !liked ? "Added to liked routes" : "Removed from liked routes";
    ToastUtils.createToast(context, message);
  }
}
