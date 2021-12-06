import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_button_follow.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardUser extends StatefulWidget {
  final String name;
  final int level;
  int followers;
  int following;
  final String button1;
  final bool clickable;
  final bool followingUserFlag;
  final double borderRadius;
  final Function callback;
  final Function callbackButton;
  final Color color;

  CardUser(
      {required this.callback,
      required this.callbackButton,
      this.name = "",
      this.level = 1,
      this.followers = 0,
      this.following = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.button1 = "",
      this.color = Colors.green,
      this.followingUserFlag = false,
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
        color: widget.color,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: InkWell(
          child: Stack(
            children: <Widget>[
              CardWidgetUtils.createClickableCard(
                  Container(
                      height: 110,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                      )),
                  widget.callback),
              IgnorePointer(child: _createListProfile()),
              Container(
                  height: 105,
                  alignment: Alignment.bottomCenter,
                  child: InputButtonFollow(
                    followCallback: widget.callbackButton,
                    following: widget.followingUserFlag,
                  )),
            ],
          ),
        ));
  }

  Widget _createListProfile() {
    return ListTile(
      leading: SizedBox(
          width: 58,
          height: 10,
          child: Wrap(
            children: [
              const Image(
                image: AssetImage("assets/logo.png"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                alignment: Alignment.center,
                child: Text(
                  "Level ${widget.level}",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )),
      title: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Column(
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
        ],
      ),
    );
  }
}
