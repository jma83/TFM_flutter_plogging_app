import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/entity_data.dart';

class RouteData extends EntityData {
  String? id;
  String? name;
  String? description;
  String? userId;
  Timestamp? startDate = Timestamp.now();
  Timestamp? endDate = Timestamp(0, 0);
  int? duration;
  List<GeoPoint> locationArray;
  double? distance;
  String? image;

  RouteData(
      {this.id = "",
      this.name = "",
      this.description = "",
      this.userId = "",
      this.startDate,
      this.endDate,
      this.duration = 0,
      this.image = "",
      this.distance = 0,
      this.locationArray = const []})
      : super();

  static Map<String, Object> castRouteToMap(RouteData route) {
    Map<String, Object> requiredFields = {
      RouteFieldData.name: route.name!,
      RouteFieldData.description: route.description!,
      RouteFieldData.userId: route.userId!
    };
    final Timestamp startDate =
        route.startDate != null ? route.startDate! : Timestamp.now();
    final double distance = route.distance!;
    final int duration = route.duration!;
    List<GeoPoint> locationArray = route.locationArray;
    Timestamp endDate =
        route.endDate != null ? route.endDate! : Timestamp.now();
    requiredFields.addAll({
      RouteFieldData.startDate: startDate,
      RouteFieldData.distance: distance,
      RouteFieldData.duration: duration,
      RouteFieldData.locationArray: locationArray,
      RouteFieldData.endDate: endDate
    });

    if (route.image != null) {
      requiredFields.addAll({RouteFieldData.image: route.image!});
    }
    return requiredFields;
  }

  static RouteData castMapToRoute(Map<String, dynamic> map, String id) {
    final image = map[RouteFieldData.image] != null
        ? map[RouteFieldData.image] as String
        : "";
    final originalList = map[RouteFieldData.locationArray] != null
        ? map[RouteFieldData.locationArray] as List<dynamic>
        : [];
    final List<GeoPoint> geoList = List<GeoPoint>.from(originalList.map(
        (elem) => GeoPoint(elem.latitude as double, elem.longitude as double)));
    return RouteData(
        id: id,
        name: map[RouteFieldData.name] as String,
        description: map[RouteFieldData.description] as String,
        userId: map[RouteFieldData.userId] as String,
        duration: map[RouteFieldData.duration] as int,
        startDate: map[RouteFieldData.startDate] as Timestamp,
        endDate: map[RouteFieldData.endDate] as Timestamp,
        distance: map[RouteFieldData.distance] as double,
        image: image,
        locationArray: geoList);
  }
}

class RouteFieldData {
  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
  static const String userId = "userId";
  static const String startDate = "startDate";
  static const String endDate = "endDate";
  static const String duration = "duration";
  static const String image = "image";
  static const String distance = "distance";
  static const String locationArray = "locationArray";
}
