import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/utils/text_widget_utils.dart';

class CardProgressUser extends StatelessWidget {
  final int value;
  final Function redirectCallback;
  const CardProgressUser(
      {required this.value, required this.redirectCallback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: InkWell(child: getCardProgress())));
  }

  Widget getCardProgress() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today's plogging progress:",
              style: TextWidgetUtils.getTitleStyleText(fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: 105,
                width: 105,
                child: CircularProgressIndicator(
                  value: value / 100,
                  semanticsLabel: "Today's plogging progress",
                  backgroundColor: Colors.green[300],
                  strokeWidth: 10.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                "$value%\n",
                style: TextWidgetUtils.getRegularStyleText(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                "\n\nCompleted",
                style: TextWidgetUtils.getRegularStyleText(fontSize: 13),
                textAlign: TextAlign.center,
              )
            ]),
            const SizedBox(height: 10),
            value == 100
                ? const Text(
                    "Well done! you have complete your today's challenge",
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    "To achieve the objetive you have to do 7 km a day. \nStart a route now to improve your progress",
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(
              height: 10,
            ),
            InputButton(
                icon: const Icon(Icons.run_circle_outlined),
                label: const Text("Start a route!"),
                horizontalPadding: 10,
                onPress: redirectCallback)
          ],
        ));
  }
}
