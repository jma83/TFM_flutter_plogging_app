// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_plogging/src/core/domain/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';

class RouteListData extends RouteData {
  bool isLiked;
  String? likeId;

  RouteListData(
      {required RouteData routeData, this.likeId, this.isLiked = false})
      : super(
            id: routeData.id,
            name: routeData.name,
            description: routeData.description,
            userId: routeData.userId,
            distance: routeData.distance,
            duration: routeData.duration,
            endDate: routeData.endDate,
            image: routeData.image,
            locationArray: routeData.locationArray,
            startDate: routeData.startDate);

  static List<RouteListData> createListFromRoutesAndLikes(
      List<RouteData> routes, List<LikeData> likes) {
    return routes.map((RouteData route) {
      LikeData? likeData =
          likes.firstWhereOrNull((element) => element.routeId == route.id);
      return RouteListData(
          routeData: route, likeId: likeData?.id, isLiked: likeData != null);
    }).toList();
  }
}
