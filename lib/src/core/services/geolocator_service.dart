import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

// Google Maps API Key
const String apiKey = "AIzaSyBQRMdZ6WuXDzw2gUFklXZuQU4L1Sk7ntg";

@injectable
class GeolocatorService {
  final PolylinePoints _polylinePoints;
  GeolocatorService(this._polylinePoints);

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
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    if (locationPermission == LocationPermission.denied) return false;
    if (locationPermission == LocationPermission.deniedForever) return false;

    return true;
  }

  Future<List<LatLng>> createPolylines(List<LatLng> polylineCoordinates,
      Position startPoint, Position endPoint) async {
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(startPoint.latitude, startPoint.longitude),
      PointLatLng(endPoint.latitude, endPoint.longitude),
      travelMode: TravelMode.walking,
    );
    print("result ${result.errorMessage} ${result.status}");

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates = [
          ...polylineCoordinates,
          LatLng(point.latitude, point.longitude)
        ];
      });
    }
    return polylineCoordinates;
  }

  Polyline generatePolyline(
      PolylineId polylineId, List<LatLng> polylineCoordinates, Color color) {
    return Polyline(
      polylineId: polylineId,
      color: color,
      points: polylineCoordinates,
      width: 3,
    );
  }

  double calculateDistance(LatLng startPoint, LatLng endPoint) {
    return Geolocator.distanceBetween(startPoint.latitude, startPoint.longitude,
        endPoint.latitude, endPoint.longitude);
  }

  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
