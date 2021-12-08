import 'package:flutter_plogging/src/core/domain/route_data.dart';

class RouteListData extends RouteData {
  bool isLiked;

  RouteListData({required RouteData routeData, this.isLiked = false})
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
}
