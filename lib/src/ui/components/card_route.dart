import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button_like.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';
import 'package:flutter_plogging/src/utils/text_widget_utils.dart';

class CardRoute extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String authorName;
  final double distance;
  final String? image;
  final String imagePlaceholder;
  final double height;
  final double borderRadius;
  final Color? color;
  final String date;
  final Function callback;
  final Function callbackLike;
  final bool isLiked;

  const CardRoute(
      {required this.id,
      required this.callback,
      required this.callbackLike,
      this.name = "",
      this.description = "",
      this.authorName = "",
      this.distance = 0,
      this.image = "assets/img1.jpg",
      this.imagePlaceholder = "assets/recycle.gif",
      this.height = 130,
      this.borderRadius = 20,
      this.color,
      this.date = "",
      this.isLiked = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CardWidgetUtils.createClickableCard(
          CardWidgetUtils.createCardContainer(card(context), borderRadius),
          callback),
      Container(
          width: MediaQuery.of(context).size.width - 20,
          height: description != "" ? 240 : 225,
          alignment: Alignment.bottomRight,
          child: InputButtonLike(
              id: id, liked: isLiked, likeCallback: callbackLike))
    ]);
  }

  card(BuildContext context) {
    final card = Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(color: color ?? Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: getCardInfoInColumn(context),
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10, bottom: 10)),
        SizedBox(
          child: image != null && image != ""
              ? CardWidgetUtils.getImageFromNetwork(image!,
                  fit: BoxFit.cover, height: height, avatar: false)
              : CardWidgetUtils.getImageFromAsset(
                  fit: BoxFit.cover, height: height, avatar: false),
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
    return card;
  }

  List<Widget> getCardInfoInColumn(BuildContext context) {
    return [
      Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 1, color: Colors.black54, style: BorderStyle.solid)),
        child: Text(name,
            textAlign: TextAlign.center,
            style: TextWidgetUtils.getRegularStyleText(
                color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 10),
      description != "" ? Text("Description: $description") : Container(),
      const SizedBox(height: 5),
      Text("Distance: $distance meters"),
      const SizedBox(height: 5),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Date: $date"),
          Text("Author: $authorName"),
        ],
      )
    ];
  }
}
