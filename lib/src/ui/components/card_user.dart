import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardUser extends StatefulWidget {
  String name;
  int level;
  int followers;
  int following;
  String button1;
  bool clickable;
  double borderRadius;
  Function? callback;
  CardUser(
      {this.name = "",
      this.level = 1,
      this.followers = 0,
      this.following = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.callback,
      this.button1 = "",
      Key? key})
      : super(key: key);

  @override
  _CardUserState createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: InkWell(
          child: Stack(
            children: <Widget>[
              CardWidgetUtils.createClickableCard(
                  Container(
                      height: 100,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                      )),
                  () {}),
              IgnorePointer(child: _createListProfile()),
              Container(
                height: 105,
                alignment: Alignment.bottomCenter,
                child: InputButton(
                  width: 130,
                  label: Text(widget.button1),
                  onPress: () => widget.callback!(),
                  buttonType: InputButtonType.outlined,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _createListProfile() {
    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage("assets/logo.png"),
            width: 60,
          ),
          Text("Level: ")
        ],
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            widget.name,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Followers: ${widget.followers}",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 10),
              Text(
                "Following: ${widget.following}",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ],
      ),
      subtitle: SizedBox(
        height: 50,
      ),
    );
  }
}
