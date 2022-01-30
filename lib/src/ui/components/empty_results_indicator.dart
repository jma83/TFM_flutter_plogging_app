import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';
import 'package:flutter_plogging/src/utils/text_widget_utils.dart';

class EmptyResultsIndicator extends StatelessWidget {
  final String text;
  final double? fontSize;
  const EmptyResultsIndicator({required this.text, this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(image: AssetImage(CardWidgetUtils.notFoundImg), width: 50),
        const SizedBox(height: 12),
        Text(
          text,
          style: TextWidgetUtils.getTitleStyleText(fontSize: fontSize ?? 16),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
