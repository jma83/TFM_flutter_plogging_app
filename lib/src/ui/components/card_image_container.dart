import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';

class CardImageContainer extends StatefulWidget {
  CardImageContainer(
      {this.cardType = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.height,
      this.callback,
      this.image = "assets/img1.jpg",
      this.imagePlaceholder = "assets/jar-loading.gif",
      this.text = "",
      Key? key})
      : super(key: key);

  int cardType;
  bool clickable;
  double borderRadius;
  double? height;
  Function? callback;
  String image;
  String imagePlaceholder;
  String text;
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
      case 3:
        return _createCardContainer(_card3());
      case 2:
        return _createCardContainer(_card2());
      case 0:
      default:
        return _createCardContainer(_card1());
    }
  }

  _card1() {
    final card = Column(
      children: <Widget>[
        Container(
          child: FadeInImage(
            image: AssetImage(widget.image),
            placeholder: AssetImage(widget.imagePlaceholder),
            height: widget.height,
            fadeInDuration: const Duration(milliseconds: 200),
            fit: BoxFit.cover,
          ),
          width: MediaQuery.of(context).size.width,
        ),
        Container(
            child: Center(
                child: Text(
              widget.text,
              textAlign: TextAlign.center,
            )),
            padding: const EdgeInsets.all(10))
      ],
    );
    return card;
  }

  _card2() {
    final card = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          child: FadeInImage(
            image: AssetImage(widget.image),
            placeholder: AssetImage(widget.imagePlaceholder),
            fadeInDuration: const Duration(milliseconds: 200),
            fit: BoxFit.fitWidth,
            height: widget.height,
          ),
          width: MediaQuery.of(context).size.width,
        ),
        Center(
            child: InputButton(
                label: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                ),
                onPress: () {},
                buttonType: InputButtonType.elevated)),
      ],
    );
    return card;
  }

  _card3() {
    final card = Column(
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
                child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
            padding: const EdgeInsets.all(10)),
        Container(
          child: FadeInImage(
            image: AssetImage(widget.image),
            placeholder: AssetImage(widget.imagePlaceholder),
            height: widget.height,
            fadeInDuration: const Duration(milliseconds: 200),
            fit: BoxFit.cover,
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
    return card;
  }

  Widget _createCardContainer(Widget card) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
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
          borderRadius: BorderRadius.circular(widget.borderRadius),
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
