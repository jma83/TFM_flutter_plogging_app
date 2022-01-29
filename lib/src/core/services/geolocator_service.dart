import 'package:flutter_plogging/src/core/services/interfaces/i_geolocator_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

// Google Maps API Key
const String apiKey = "AIzaSyBQRMdZ6WuXDzw2gUFklXZuQU4L1Sk7ntg";

@injectable
class GeolocatorService extends IGeolocatorService {
  final PolylinePoints _polylinePoints;
  GeolocatorService(this._polylinePoints);

  @override
  Stream<ServiceStatus> getStreamLocationStatus() {
    return Geolocator.getServiceStatusStream();
  }

  @override
  Stream<Position> getStreamLocationPosition() {
    return Geolocator.getPositionStream();
  }

  @override
  Future<Position> getCurrentLocation() async {
    if (!await validateLocationService()) {
      if (!await _requestLocationPermission()) {
        return Future.error('Location services are disabled.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> validateLocationService() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    if (locationPermission == LocationPermission.denied) return false;
    if (locationPermission == LocationPermission.deniedForever) return false;

    return true;
  }

  @override
  Future<List<LatLng>> createPolylines(
      LatLng startPoint, LatLng endPoint) async {
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(startPoint.latitude, startPoint.longitude),
      PointLatLng(endPoint.latitude, endPoint.longitude),
      travelMode: TravelMode.walking,
    );

    if (result.points.isEmpty) {
      return [];
    }
    return result.points.map((PointLatLng point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();
  }

  @override
  double calculateDistance(LatLng startPoint, LatLng endPoint) {
    return Geolocator.distanceBetween(startPoint.latitude, startPoint.longitude,
        endPoint.latitude, endPoint.longitude);
  }

  @override
  double calculateDirection(LatLng startPoint, LatLng endPoint) {
    return Geolocator.bearingBetween(startPoint.latitude, startPoint.longitude,
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
