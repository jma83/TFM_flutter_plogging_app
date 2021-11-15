import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RouteData {
  String name;
  String description;
  String userId;
  DateTime? startDate = DateTime.now();
  DateTime? endDate;
  Timestamp? duration = Timestamp(0, 0);
  Image? image;

  RouteData(
      {this.name = "",
      this.description = "",
      this.userId = "",
      this.startDate,
      this.endDate,
      this.duration,
      this.image});
}

class RouteFieldData {
  static const String name = "name";
  static const String description = "description";
  static const String userId = "userId";
  static const String startDate = "startDate";
  static const String endDate = "endDate";
  static const String duration = "duration";
  static const String image = "image";
}
