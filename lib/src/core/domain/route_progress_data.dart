import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  ServiceStatus serviceStatus;
  Position currentPosition;
  Position? lastPosition;
  double currentZoom = 3;
  List<LatLng> polylinePointList = [];
  Map<PolylineId, Polyline> polylines = {};

  RouteProgressData(
      {this.serviceStatus = ServiceStatus.disabled,
      this.currentPosition = defautLocation,
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
}
