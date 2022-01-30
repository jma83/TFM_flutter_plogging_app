import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/utils/toast_utils.dart';

class InputButtonFollow extends StatelessWidget {
  final bool following;
  final bool isSelf;
  final double width;
  final Function followCallback;
  const InputButtonFollow(
      {required this.following,
      required this.followCallback,
      this.width = 130,
      this.isSelf = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSelf) {
      return Container();
    }
    if (!following) {
      return InputButton(
          width: width,
          label: const Text("Follow"),
          onPress: () => buttonClick(context),
          buttonType: InputButtonType.outlined,
          horizontalPadding: 10);
    }
    return InputButton(
        width: width,
        label: const Text("Following"),
        onPress: () => buttonClick(context),
        buttonType: InputButtonType.elevated,
        bgColor: Colors.blue,
        horizontalPadding: 10);
  }

  buttonClick(BuildContext context) {
    _showToast(context);
    followCallback();
  }

  void _showToast(BuildContext context) {
    final String message = !following ? "Followed user!" : "Unfollowed user";
    ToastUtils.createToast(context, message);
  }
}
