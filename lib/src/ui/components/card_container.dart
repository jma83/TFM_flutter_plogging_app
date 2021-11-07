import 'package:flutter/material.dart';

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
    Widget card = _createCard(widget);
    if (widget.clickable && widget.callback != null) {
      card = _createClickableCard(card, widget.callback!);
    }
    return card;
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
              ListTile(
                leading: const Icon(Icons.photo_album, color: Colors.blue),
                title: Text(cardContainer.title),
                subtitle: Text(cardContainer.description),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      onPressed: () => cardContainer.callback!(),
                      child: Text(cardContainer.button1)),
                  TextButton(
                      onPressed: () => cardContainer.callback!(),
                      child: Text(cardContainer.button2))
                ],
              )
            ],
          ),
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
