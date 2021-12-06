import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_button_like.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardRoute extends StatefulWidget {
  final String name;
  final String description;
  final String authorName;
  final double distance;
  final String? image;
  final String imagePlaceholder;
  final double? height;
  final double borderRadius;
  final Color? color;
  final String date;

  CardRoute(
      {this.name = "",
      this.description = "",
      this.authorName = "",
      this.distance = 0,
      this.image = "assets/img1.jpg",
      this.imagePlaceholder = "assets/jar-loading.gif",
      this.height,
      this.borderRadius = 20,
      this.color,
      this.date = "",
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
          () {}),
      Container(
          width: MediaQuery.of(context).size.width - 20,
          height: widget.description != "" ? 240 : 225,
          alignment: Alignment.bottomRight,
          child: InputButtonLike(liked: false, likeCallback: () {}))
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
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1,
                            color: Colors.black54,
                            style: BorderStyle.solid)),
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),
                widget.description != ""
                    ? Text("Description: ${widget.description}")
                    : Container(),
                SizedBox(height: 5),
                Text("Distance: ${widget.distance} meters"),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date: ${widget.date}"),
                    Text("Author: ${widget.authorName}"),
                  ],
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10, bottom: 10)),
        SizedBox(
          child: widget.image != null && widget.image != ""
              ? getImageFromNetwork()
              : getImageFromAsset(),
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
    return card;
  }

  getImageFromNetwork() {
    return FadeInImage.assetNetwork(
      image: widget.image!,
      placeholder: widget.imagePlaceholder,
      height: widget.height,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: BoxFit.cover,
    );
  }

  getImageFromAsset() {
    final String image = "assets/img1.jpg";
    return FadeInImage(
        image: AssetImage(image),
        placeholder: AssetImage(widget.imagePlaceholder),
        height: widget.height,
        fadeInDuration: const Duration(milliseconds: 200),
        fit: BoxFit.cover);
  }
}
