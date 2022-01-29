import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IGeolocatorService {
  Stream<ServiceStatus> getStreamLocationStatus();
  Stream<Position> getStreamLocationPosition();
  Future<Position> getCurrentLocation();
  Future<bool> validateLocationService();
  Future<List<LatLng>> createPolylines(LatLng startPoint, LatLng endPoint);
  double calculateDistance(LatLng startPoint, LatLng endPoint);
  double calculateDirection(LatLng startPoint, LatLng endPoint);
}
