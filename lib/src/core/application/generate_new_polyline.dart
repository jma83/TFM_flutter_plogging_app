import 'package:flutter/cupertino.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateNewPolyline {
  final GeolocatorService _geolocatorService;
  final UuidGeneratorService _uuidGeneratorService;
  GenerateNewPolyline(this._geolocatorService, this._uuidGeneratorService);

  Future<Polyline?> execute(List<LatLng> currentList, LatLng lastPosition,
      LatLng currentPosition, Color color) async {
    final PolylineId polylineId = PolylineId(_uuidGeneratorService.generate());
    List<LatLng> polylinePointList = await _geolocatorService.createPolylines(
        currentList, lastPosition, currentPosition);
    if (currentList.length == polylinePointList.length) return null;

    currentList = [...polylinePointList];
    return _generatePolyline(polylineId, polylinePointList, color);
  }

  Polyline _generatePolyline(
      PolylineId polylineId, List<LatLng> polylineCoordinates, Color color) {
    return Polyline(
      polylineId: polylineId,
      color: color,
      points: polylineCoordinates,
      width: 3,
    );
  }
}
