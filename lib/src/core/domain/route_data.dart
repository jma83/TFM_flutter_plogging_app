import 'package:cloud_firestore/cloud_firestore.dart';

class RouteData {
  String name;
  String description;
  String userId;
  Timestamp? startDate = Timestamp.now();
  Timestamp? endDate = Timestamp(0, 0);
  int? duration = 0;
  List<GeoPoint>? locationArray = [];
  int? distance = 0;
  String? image = "";

  RouteData(
      {required this.name,
      required this.description,
      required this.userId,
      this.startDate,
      this.endDate,
      this.duration,
      this.image,
      this.distance,
      this.locationArray});
}

class RouteFieldData {
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
