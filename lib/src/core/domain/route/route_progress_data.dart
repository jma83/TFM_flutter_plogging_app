import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const Position defautLocation = Position(
    accuracy: 1.0,
    altitude: 0,
    heading: 0,
    latitude: 0,
    longitude: 0,
    speed: 0,
    speedAccuracy: 1.0,
    timestamp: null);

class RouteProgressData extends RouteData {
  Position currentPosition;
  Position? lastPosition;
  double currentZoom = 3;
  List<LatLng> polylinePointList = [];
  Map<PolylineId, Polyline> polylines = {};

  RouteProgressData(
      {this.currentPosition = defautLocation,
      this.lastPosition,
      this.currentZoom = 3,
      this.polylinePointList = const [],
      this.polylines = const {},
      id,
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
    userId = userId;
  }

  completeProgressData(double distance) {
    locationArray = GeoPointUtils.convertLatLngToGeopoints(polylinePointList);
    endDate = Timestamp.now();
    duration =
        DateCustomUtils.calcDateDifference(startDate!, endDate!).inSeconds;
    distance = distance;
  }

  confirmProgressData() {
    final DateTime now = DateTime.now();
    name = name == ""
        ? "Route ${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}:${now.second}"
        : name;
    description = description ?? "";
  }
}
