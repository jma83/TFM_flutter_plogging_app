import 'package:flutter_plogging/src/core/domain/route/route_camera_position_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/services/geolocator_service.dart';
import 'package:flutter_plogging/src/utils/app_constants.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalculateRouteCameraPosition {
  final GeolocatorService _geolocatorService;

  CalculateRouteCameraPosition(this._geolocatorService);

  RouteCameraPosition execute(RouteData route) {
    double accLat = 0;
    double accLong = 0;
    double latitudeMedian = 0;
    double longitudeMedian = 0;
    double distance = getDistanceBetweenFirstAndLast(route);
    double zoom = calculateZoom(distance);

    for (int i = 0; i < route.locationArray.length; i++) {
      accLat += route.locationArray[i].latitude;
      accLong += route.locationArray[i].longitude;
    }
    latitudeMedian = accLat / route.locationArray.length;
    longitudeMedian = accLong / route.locationArray.length;

    return RouteCameraPosition(zoom, LatLng(latitudeMedian, longitudeMedian));
  }

  getDistanceBetweenFirstAndLast(RouteData route) {
    final firstPoint =
        GeoPointUtils.convertGeopointToLatLng(route.locationArray[0]);
    final secondPoint = GeoPointUtils.convertGeopointToLatLng(
        route.locationArray[route.locationArray.length - 1]);
    return _geolocatorService.calculateDistance(firstPoint, secondPoint);
  }

  double calculateZoom(double distance) {
    double tmpDistance = distance;
    int contSize = 0;
    while (tmpDistance > AppConstants.distanceZoomFactor &&
        tmpDistance > AppConstants.minDistance) {
      tmpDistance = tmpDistance / AppConstants.distanceZoomFactor;
      contSize++;
    }
    final zoom = AppConstants.maxZoom - contSize;
    return zoom < AppConstants.minZoom ? AppConstants.minZoom : zoom;
  }
}
