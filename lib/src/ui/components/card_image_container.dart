import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';
import 'package:flutter_plogging/src/utils/image_widget_utils.dart';

class CardImageContainer extends StatelessWidget {
  const CardImageContainer(
      {this.image,
      this.cardType = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.height,
      this.callback,
      this.text = "",
      Key? key})
      : super(key: key);

  final int cardType;
  final bool clickable;
  final double borderRadius;
  final double? height;
  final Function? callback;
  final String text;
  final String? image;

  @override
  Widget build(BuildContext context) {
    Widget card = _createCard(context);
    if (clickable) {
      card = CardWidgetUtils.createClickableCard(card, callback);
    }
    return card;
  }

  Widget _createCard(BuildContext context) {
    switch (cardType) {
      case 3:
        return _createCardContainer(_card3(context));
      case 2:
        return _createCardContainer(_card2(context));
      case 0:
      default:
        return _createCardContainer(_card1(context));
    }
  }

  _card1(BuildContext context) {
    final card = Column(
      children: <Widget>[
        SizedBox(
          child: ImageWidgetUtils.getImageFromAsset(
              imageSrc: image,
              height: height,
              fit: BoxFit.cover,
              avatar: false,
              rounded: false),
          width: MediaQuery.of(context).size.width,
        ),
        Container(
            child: Center(
                child: Text(
              text,
              textAlign: TextAlign.center,
            )),
            padding: const EdgeInsets.all(10))
      ],
    );
    return card;
  }

  _card2(BuildContext context) {
    final card = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          child: ImageWidgetUtils.getImageFromAsset(
              height: height,
              fit: BoxFit.fitWidth,
              avatar: false,
              rounded: false),
          width: MediaQuery.of(context).size.width,
        ),
        Center(
            child: InputButton(
                label: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
                onPress: () {},
                buttonType: InputButtonType.elevated)),
      ],
    );
    return card;
  }

  _card3(BuildContext context) {
    final card = Column(
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
                child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
            padding: const EdgeInsets.all(10)),
        SizedBox(
          child: ImageWidgetUtils.getImageFromAsset(
              imageSrc: image,
              height: height,
              fit: BoxFit.cover,
              avatar: false,
              rounded: false),
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
    return card;
  }

  Widget _createCardContainer(Widget card) {
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
}
