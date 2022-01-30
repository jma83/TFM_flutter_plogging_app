import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/utils/image_widget_utils.dart';
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
                      ? ImageWidgetUtils.getImageFromAsset(avatar: true)
                      : ImageWidgetUtils.getImageFromNetwork(image!,
                          avatar: true,
                          height: 200,
                          width: 200,
                          rounded: true,
                          fit: BoxFit.cover))),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Level: $level",
                          style: const TextStyle(fontSize: 12),
                        ),
                        decoration: ImageWidgetUtils.badgeTextDecoration,
                      )
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
