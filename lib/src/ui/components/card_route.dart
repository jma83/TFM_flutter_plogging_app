import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button_like.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardRoute extends StatefulWidget {
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

  CardRoute(
      {required this.id,
      required this.callback,
      required this.callbackLike,
      this.name = "",
      this.description = "",
      this.authorName = "",
      this.distance = 0,
      this.image = "assets/img1.jpg",
      this.imagePlaceholder = "assets/jar-loading.gif",
      this.height = 130,
      this.borderRadius = 20,
      this.color,
      this.date = "",
      this.isLiked = false,
      Key? key})
      : super(key: key);

  @override
  _CardRouteState createState() => _CardRouteState();
}

class _CardRouteState extends State<CardRoute> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CardWidgetUtils.createClickableCard(
          CardWidgetUtils.createCardContainer(card(), widget.borderRadius),
          widget.callback),
      Container(
          width: MediaQuery.of(context).size.width - 20,
          height: widget.description != "" ? 240 : 225,
          alignment: Alignment.bottomRight,
          child: InputButtonLike(
              id: widget.id,
              liked: widget.isLiked,
              likeCallback: widget.callbackLike))
    ]);
  }

  card() {
    final card = Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(color: widget.color ?? Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: getCardInfoInColumn(),
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10, bottom: 10)),
        SizedBox(
          child: widget.image != null && widget.image != ""
              ? CardWidgetUtils.getImageFromNetwork(widget.image!,
                  fit: BoxFit.cover, height: widget.height, avatar: false)
              : CardWidgetUtils.getImageFromAsset(
                  fit: BoxFit.cover, height: widget.height, avatar: false),
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
    return card;
  }

  List<Widget> getCardInfoInColumn() {
    return [
      Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1, color: Colors.black54, style: BorderStyle.solid)),
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.bold),
          )),
      const SizedBox(height: 10),
      widget.description != ""
          ? Text("Description: ${widget.description}")
          : Container(),
      const SizedBox(height: 5),
      Text("Distance: ${widget.distance} meters"),
      const SizedBox(height: 5),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Date: ${widget.date}"),
          Text("Author: ${widget.authorName}"),
        ],
      )
    ];
  }
}
