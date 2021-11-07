import 'package:flutter/material.dart';

class CardContainer extends StatefulWidget {
  CardContainer(
      {this.cardType = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.callback,
      Key? key})
      : super(key: key);

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
        return _card0(cardContainer.borderRadius);
    }
  }

  _card0(double borderRadius) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: InkWell(
          child: Column(
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.photo_album, color: Colors.blue),
                title: Text("Soy el titulo de esta tarjeta"),
                subtitle: Text("Aqui estamos con la descripcion"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(onPressed: () {}, child: const Text("Elpepe")),
                  TextButton(onPressed: () {}, child: const Text("Elpepe2"))
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
