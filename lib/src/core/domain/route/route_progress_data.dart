import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteProgressData extends RouteData {
  RouteProgressData(
      {id,
      name,
      description,
      userId,
      startDate,
      endDate,
      duration,
      image,
      distance,
      List<GeoPoint> locationArray = const []})
      : super(
            id: id,
            name: name,
            description: description,
            userId: userId,
            startDate: startDate,
            endDate: endDate,
            duration: duration,
            image: image,
            distance: distance,
            locationArray: locationArray);

  startProgressData(String userId) {
    startDate = Timestamp.now();
    this.userId = userId;
  }

  completeProgressData(double distance, List<LatLng> polylinePointList) {
    locationArray = GeoPointUtils.convertLatLngToGeopoints(polylinePointList);
    endDate = Timestamp.now();
    duration =
        DateCustomUtils.calcDateDifference(startDate!, endDate!).inSeconds;
    this.distance = distance;
  }

  confirmProgressData() {
    final DateTime now = DateTime.now();
    name = name == ""
        ? "Route ${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}:${now.second}"
        : name;
    description = description ?? "";
  }
}
