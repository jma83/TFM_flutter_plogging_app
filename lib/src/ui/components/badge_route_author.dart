import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class BadgeRouteAuthor extends StatelessWidget {
  final String name;
  final int level;
  final String date;
  final String? image;
  final Function callbackAuthor;
  const BadgeRouteAuthor(
      {required this.name,
      required this.level,
      required this.date,
      required this.callbackAuthor,
      this.image,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidgetUtils.createClickableCard(
        ListTile(
          leading: Container(
              margin: const EdgeInsets.only(top: 12),
              child: SizedBox(
                  width: 45,
                  height: 45,
                  child: image == null || image == ""
                      ? CardWidgetUtils.getImageFromAsset(avatar: true)
                      : CardWidgetUtils.getImageFromNetwork(image!,
                          avatar: true, rounded: true))),
          title: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Level: $level",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          trailing: Text(
            "Date: $date",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.end,
          ),
        ),
        callbackAuthor);
  }
}
