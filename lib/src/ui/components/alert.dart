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

  static Widget createCustomOptionsAlert(String title, Widget content,
      Function confirmAction, Function dismissAction,
      {double width = 300, double height = 500}) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(18.0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.green,
          ],
        )),
        child: content,
      ),
      contentPadding: EdgeInsets.all(0.0),
      actions: getButtonChoices(confirmAction, dismissAction),
    );
  }

  static Widget createCustomConfirmationAlert(
      String title, Widget content, Function action) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        width: 250,
        height: 400,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.green,
          ],
        )),
        child: content,
      ),
      contentPadding: EdgeInsets.all(0.0),
      actions: getButtonConfirmation(action),
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
