import 'package:flutter/material.dart';

class CardImageContainer extends StatefulWidget {
  CardImageContainer(
      {this.cardType = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.height,
      this.callback,
      this.image = "assets/img1.jpg",
      this.imagePlaceholder = "assets/jar-loading.gif",
      Key? key})
      : super(key: key);

  int cardType;
  bool clickable;
  double borderRadius;
  double? height;
  Function? callback;
  String image;
  String imagePlaceholder;
  @override
  _CardImageContainerState createState() => _CardImageContainerState();
}

class _CardImageContainerState extends State<CardImageContainer> {
  @override
  Widget build(BuildContext context) {
    Widget card = _createCard(widget);
    if (widget.clickable) {
      card = _createClickableCard(card, widget.callback);
    }
    return card;
  }

  Widget _createCard(CardImageContainer cardimage) {
    switch (cardimage.cardType) {
      case 0:
      default:
        return _card1(cardimage.image, cardimage.imagePlaceholder,
            cardimage.height, cardimage.borderRadius);
    }
  }

  _card1(String image, String imagePlaceholder, double? height,
      double borderRadius) {
    final card = Column(
      children: <Widget>[
        FadeInImage(
          image: AssetImage(image),
          placeholder: AssetImage(imagePlaceholder),
          height: height,
          fadeInDuration: const Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),
        Container(
            child: const Center(child: Text("Hola mundo!")),
            padding: const EdgeInsets.all(10))
      ],
    );
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(2, 10))
            ]),
        child: ClipRRect(
          child: card,
          borderRadius: BorderRadius.circular(borderRadius),
        ));
  }

  Widget _createClickableCard(Widget widget, Function? callback) {
    final fun = callback ?? () {};
    return Stack(
      children: [
        widget,
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => fun(),
                ))),
      ],
    );
  }
}
