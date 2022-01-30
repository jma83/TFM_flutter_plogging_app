import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/user/user_search_data.dart';
import 'package:flutter_plogging/src/ui/components/user/card_user.dart';

final List<int> colorCodes = <int>[500, 400, 700, 300, 600];

class CardUserPrefab extends StatelessWidget {
  final UserSearchData user;
  final int index;
  final Function navigateToUser;
  final Function handleFollowUser;
  final String currentUserId;
  const CardUserPrefab(
      {required this.index,
      required this.user,
      required this.navigateToUser,
      required this.handleFollowUser,
      required this.currentUserId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardUser(
      name: user.username,
      image: user.image,
      followers: user.followers,
      following: user.following,
      followingUserFlag: user.followingFlag,
      color: Colors.green[colorCodes[index % 5]]!,
      clickable: true,
      isSelf: currentUserId == user.id,
      callback: () => navigateToUser(user),
      callbackButton: () => handleFollowUser(user),
    );
  }
}
