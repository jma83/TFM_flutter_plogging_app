import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

const String apiKey = "AIzaSyBQRMdZ6WuXDzw2gUFklXZuQU4L1Sk7ntg";

@injectable
class GeolocatorService {
  PolylinePoints polylinePoints;
  GeolocatorService(this.polylinePoints);

  Stream<ServiceStatus> getStreamLocationStatus() {
    return Geolocator.getServiceStatusStream();
  }

  Stream<Position> getStreamLocationPosition() {
    return Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> getCurrentLocation() async {
    if (!await validateLocationService()) {
      if (!await _requestLocationPermission()) {
        return Future.error('Location services are disabled.');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> validateLocationService() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }
    if (locationPermission == LocationPermission.denied) {
      return false;
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  createPolylines(
      List<LatLng> polylineCoordinates,
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      String polylineUuid) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId polylineId = PolylineId(polylineUuid);

    return Polyline(
      polylineId: polylineId,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
  }

  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
