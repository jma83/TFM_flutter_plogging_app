import 'package:flutter/material.dart';

class TopNavigationBar {
  static AppBar getTopNavigationBar(
      {required String title,
      required bool isBackVisible,
      Function? goBackCallback}) {
    return AppBar(
        title: Text(title),
        leading: isBackVisible
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => goBackCallback!())
            : Container());
  }
}
