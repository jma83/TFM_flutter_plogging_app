import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalculatePointsDirection {
  final GeolocatorService _geolocatorService;

  CalculatePointsDirection(this._geolocatorService);

  double execute(List<LatLng> pointList) {
    double distance = 0;
    for (int i = 0; i < pointList.length; i++) {
      if (i == 0) continue;
      distance +=
          _geolocatorService.calculateDirection(pointList[i - 1], pointList[i]);
    }
    return distance;
  }

  double executeByPositions(List<Position> positionList) {
    return execute(
        positionList.map((e) => LatLng(e.latitude, e.longitude)).toList());
  }
}
