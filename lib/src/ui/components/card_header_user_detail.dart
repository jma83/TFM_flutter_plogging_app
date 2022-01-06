import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/user_search_data.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_button_follow.dart';
import 'package:flutter_plogging/src/utils/card_widget_utils.dart';

class CardHeaderUserDetail extends StatelessWidget {
  final UserSearchData user;
  final String genderFormatted;
  final String creationDate;
  final bool isSelf;
  final int? maxXp;
  final int? xp;
  final Function? followUserCallback;
  final Function? editUserCallback;

  const CardHeaderUserDetail(
      {required this.user,
      required this.genderFormatted,
      required this.creationDate,
      required this.isSelf,
      this.maxXp,
      this.xp,
      this.followUserCallback,
      this.editUserCallback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getAvatar(context),
            const SizedBox(
              height: 10,
            ),
            getUsername(),
            const SizedBox(
              height: 4,
            ),
            getUserLevel(),
            const SizedBox(
              height: 6,
            ),
            isSelf ? getLevelXp(context) : Container(),
            const SizedBox(
              height: 15,
            ),
            isSelf ? getEditUserData() : getFollowButton(),
            const SizedBox(
              height: 4,
            ),
            getFollowersCount(context),
            getUserDetails()
          ],
        ));
  }

  getEditUserData() {
    return InputButton(
      label: const Text("Edit profile"),
      onPress: editUserCallback ?? () {},
      width: 120,
      horizontalPadding: 10,
    );
  }

  getFollowButton() {
    return InputButtonFollow(
        following: user.followingFlag,
        followCallback: followUserCallback ?? () {});
  }

  Widget getAvatar(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        child: user.image == null || user.image == ""
            ? CardWidgetUtils.getImageFromAsset(avatar: true)
            : CardWidgetUtils.getImageFromNetwork(user.image!, avatar: true));
  }

  Widget getUsername() {
    return Center(
        child: Text(
      user.username,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    ));
  }

  Widget getUserLevel() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            color: Colors.yellow[300],
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20)),
        width: 100,
        child: Text(
          "- Level ${user.level} -",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ));
  }

  Widget getLevelXp(BuildContext context) {
    final double progress = xp != null && maxXp != null ? (xp! / maxXp!) : 0;
    final String progressText =
        xp != null && maxXp != null ? "$xp/$maxXp xp" : "0 xp";
    return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Wrap(alignment: WrapAlignment.center, children: [
          Text(
            progressText,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.green[300],
            color: Colors.black54,
          )
        ]));
  }

  Widget getFollowersCount(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Followers: ${user.followers}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 10),
          Text(
            "Following: ${user.following}",
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width / 2,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      )
    ]);
  }

  Widget getUserDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Gender: $genderFormatted",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10),
        Text(
          "Age: ${user.age}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10),
        Text(
          "Creation date: $creationDate",
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
