import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardContainer extends StatefulWidget {
  CardContainer(
      {this.title = "",
      this.description = "",
      this.cardType = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.callback,
      this.button1 = "",
      this.button2 = "",
      Key? key})
      : super(key: key);

  String title;
  String description;
  String button1;
  String button2;
  int cardType;
  bool clickable;
  double borderRadius;
  Function? callback;
  @override
  _CardContainerState createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    return _createCard(widget);
  }

  Widget _createCard(CardContainer cardContainer) {
    switch (cardContainer.cardType) {
      case 0:
      default:
        return _card0(cardContainer);
    }
  }

  _card0(CardContainer cardContainer) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardContainer.borderRadius)),
        child: InkWell(
          child: Column(
            children: <Widget>[
              widget.clickable && widget.callback != null
                  ? CardWidgetUtils.createClickableCard(
                      _createListTitle(cardContainer), () {})
                  : _createListTitle(cardContainer),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InputButton(
                    label: Text(cardContainer.button1),
                    onPress: () => cardContainer.callback!(),
                    buttonType: InputButtonType.outlined,
                  ),
                  InputButton(
                    label: Text(cardContainer.button2),
                    onPress: () => cardContainer.callback!(),
                    buttonType: InputButtonType.elevated,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _createListTitle(CardContainer cardContainer) {
    return ListTile(
      leading: const Icon(Icons.photo_album, color: Colors.blue),
      title: Text(cardContainer.title),
      subtitle: Text(cardContainer.description),
    );
  }
}
