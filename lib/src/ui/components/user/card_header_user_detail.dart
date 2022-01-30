import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/ui/components/follower/input_button_follow.dart';
import 'package:flutter_plogging/src/ui/components/shared/input_button.dart';
import 'package:flutter_plogging/src/utils/image_widget_utils.dart';
import 'package:flutter_plogging/src/utils/text_widget_utils.dart';

class CardHeaderUserDetail extends StatelessWidget {
  final UserSearchData user;
  final String genderFormatted;
  final String creationDate;
  final bool isSelf;
  final bool hideFollow;
  final int? maxXp;
  final int? xp;
  final Function? followUserCallback;
  final Function? editUserCallback;
  final Function? likedRoutesCallback;
  final Function? changeImageCallback;

  const CardHeaderUserDetail(
      {required this.user,
      required this.genderFormatted,
      required this.creationDate,
      required this.isSelf,
      this.hideFollow = false,
      this.maxXp,
      this.xp,
      this.followUserCallback,
      this.editUserCallback,
      this.likedRoutesCallback,
      this.changeImageCallback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: InkWell(
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
                  height: 8,
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
            ))));
  }

  getEditUserData() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputButton(
            label: const Text("Edit profile"),
            onPress: editUserCallback ?? () {},
            width: 120,
            horizontalPadding: 10,
          ),
          const SizedBox(
            width: 10,
          ),
          InputButton(
            buttonType: InputButtonType.outlined,
            label: const Text("Liked routes"),
            onPress: likedRoutesCallback ?? () {},
            width: 120,
            horizontalPadding: 10,
          )
        ]);
  }

  getFollowButton() {
    return InputButtonFollow(
        isSelf: hideFollow,
        following: user.followingFlag,
        followCallback: followUserCallback ?? () {});
  }

  Widget getAvatar(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        child: Stack(alignment: Alignment.bottomRight, children: [
          user.image == null || user.image == ""
              ? ImageWidgetUtils.getImageFromAsset(avatar: true)
              : ImageWidgetUtils.getImageFromNetwork(user.image!,
                  avatar: true,
                  rounded: true,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover),
          changeImageCallback == null
              ? Container()
              : FloatingActionButton.small(
                  heroTag: "avatar_upload",
                  onPressed: () => changeImageCallback!(),
                  child: const Icon(
                    Icons.camera_enhance_rounded,
                    size: 20,
                  ))
        ]));
  }

  Widget getUsername() {
    return Center(
        child: Text(
      user.username,
      style: TextWidgetUtils.getRegularStyleText(fontSize: 23),
      textAlign: TextAlign.center,
    ));
  }

  Widget getUserLevel() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: ImageWidgetUtils.badgeTextDecoration,
        width: 125,
        child: Text(
          "- Level ${user.level} -",
          style: TextWidgetUtils.getRegularStyleText(fontSize: 16),
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
