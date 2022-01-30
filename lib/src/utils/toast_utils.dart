import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static createToast(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
