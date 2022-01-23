import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardContainer extends StatelessWidget {
  const CardContainer(
      {this.title = "",
      this.description = "",
      this.cardType = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.callback1,
      this.callback2,
      this.button1 = "",
      this.button2 = "",
      Key? key})
      : super(key: key);

  final String title;
  final String description;
  final String button1;
  final String button2;
  final int cardType;
  final bool clickable;
  final double borderRadius;
  final Function? callback1;
  final Function? callback2;

  @override
  Widget build(BuildContext context) {
    return _createCard();
  }

  Widget _createCard() {
    switch (cardType) {
      case 0:
      default:
        return _card0();
    }
  }

  _card0() {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: InkWell(
          child: Column(
            children: <Widget>[
              clickable
                  ? CardWidgetUtils.createClickableCard(
                      _createListTitle(), () {})
                  : _createListTitle(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InputButton(
                    label: Text(button1),
                    onPress: () => callback1!(),
                    buttonType: InputButtonType.outlined,
                  ),
                  InputButton(
                    label: Text(button2),
                    onPress: () => callback2!(),
                    buttonType: InputButtonType.elevated,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _createListTitle() {
    return ListTile(
      leading: const Icon(Icons.photo_album, color: Colors.blue),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
