import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/ui/components/route/card_route.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:flutter_plogging/src/utils/distance_utils.dart';

final List<int> colorCodes = <int>[500, 400, 700, 300, 600];

class CardRoutePrefab extends StatelessWidget {
  final RouteListData route;
  final int index;
  final String id;
  final String authorUsername;
  final Function likeCallback;
  final Function navigateRouteCallback;

  const CardRoutePrefab(
      {required this.id,
      required this.index,
      required this.route,
      required this.authorUsername,
      required this.likeCallback,
      required this.navigateRouteCallback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardRoute(
      id: id,
      color: Colors.green[colorCodes[index % 5]],
      height: 130,
      image: route.image,
      name: route.name!,
      description: route.description ?? "",
      distance: DistanceUtils.getDistanceFormat(route.distance),
      distanceMeasure: DistanceUtils.getMeassure(route.distance),
      authorName: authorUsername,
      date: getDateFormat(route.endDate!),
      callback: () => navigateRouteCallback(route),
      callbackLike: () => likeCallback(route),
      isLiked: route.isLiked,
    );
  }

  String getDateFormat(Timestamp endDate) {
    return DateCustomUtils.dateTimeToStringFormat(endDate.toDate());
  }
}
