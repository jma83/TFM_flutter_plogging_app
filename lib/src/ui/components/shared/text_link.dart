import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextLink extends StatelessWidget {
  final String link;
  final String label;
  const TextLink({required this.label, required this.link, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: label,
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = () => launch(link),
        ));
  }
}
