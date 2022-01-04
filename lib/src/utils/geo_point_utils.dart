import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoPointUtils {
  static List<GeoPoint> convertLatLngToGeopoints(
      List<LatLng> polylinePointList) {
    return polylinePointList
        .map((element) => GeoPoint(element.latitude, element.longitude))
        .toList();
  }

  static List<LatLng> convertGeopointsToLatLng(List<GeoPoint> geoPointList) {
    return geoPointList
        .map((element) => LatLng(element.latitude, element.longitude))
        .toList();
  }

  static GeoPoint convertLatLngToGeopoint(LatLng latLng) {
    return GeoPoint(latLng.latitude, latLng.longitude);
  }

  static LatLng convertGeopointToLatLng(GeoPoint geoPoint) {
    return LatLng(geoPoint.latitude, geoPoint.longitude);
  }
}
