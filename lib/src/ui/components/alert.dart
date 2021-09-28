import 'package:flutter/material.dart';

class Alert {
  static Widget createInfoAlert(String title, String content, Function action) {
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: getButtonConfirmation(action));
  }

  static Widget createOptionsAlert(String title, String content,
      Function confirmAction, Function dismissAction) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: getButtonChoices(confirmAction, dismissAction),
    );
  }

  static getButtonChoices(Function confirmAction, Function dismissAction) {
    return <Widget>[
      TextButton(
        child: const Text("OK"),
        onPressed: () {
          confirmAction();
        },
      ),
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          dismissAction();
        },
      )
    ];
  }

  static getButtonConfirmation(Function onPress) {
    return <Widget>[
      TextButton(
        child: const Text("OK"),
        onPressed: () {
          onPress();
        },
      )
    ];
  }
}
