import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button_follow.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardUser extends StatelessWidget {
  final String name;
  final int level;
  final int followers;
  final int following;
  final bool clickable;
  final bool followingUserFlag;
  final double borderRadius;
  final Function callback;
  final Function callbackButton;
  final Color color;
  final bool isSelf;

  const CardUser(
      {required this.callback,
      required this.callbackButton,
      this.name = "",
      this.level = 1,
      this.followers = 0,
      this.following = 0,
      this.clickable = false,
      this.borderRadius = 20,
      this.color = Colors.green,
      this.followingUserFlag = false,
      this.isSelf = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: color,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: InkWell(
          child: Stack(
            children: <Widget>[
              CardWidgetUtils.createClickableCard(
                  SizedBox(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                  ),
                  callback),
              IgnorePointer(child: _createListProfile()),
              Container(
                  height: 107,
                  alignment: Alignment.bottomCenter,
                  child: InputButtonFollow(
                    isSelf: isSelf,
                    followCallback: callbackButton,
                    following: followingUserFlag,
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
                  "Level $level",
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
                name,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Followers: $followers",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Following: $following",
                    style: const TextStyle(fontSize: 14),
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
