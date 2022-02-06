import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/utils/geo_point_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalculateRouteCameraPosition {
  CalculateRouteCameraPosition();

  CameraUpdate execute(RouteData route) {
    LatLng northeast = const LatLng(0, 0);
    LatLng southwest = const LatLng(0, 0);

    for (int i = 0; i < route.locationArray.length; i++) {
      if (i == 0) {
        northeast =
            GeoPointUtils.convertGeopointToLatLng(route.locationArray[i]);
        southwest =
            GeoPointUtils.convertGeopointToLatLng(route.locationArray[i]);
        continue;
      }
      if (northeast.longitude < route.locationArray[i].longitude ||
          northeast.latitude < route.locationArray[i].latitude) {
        northeast =
            GeoPointUtils.convertGeopointToLatLng(route.locationArray[i]);
      }

      if (southwest.longitude > route.locationArray[i].longitude ||
          southwest.latitude > route.locationArray[i].latitude) {
        southwest =
            GeoPointUtils.convertGeopointToLatLng(route.locationArray[i]);
      }
    }

    LatLngBounds mapBounds =
        LatLngBounds(northeast: northeast, southwest: southwest);

    return CameraUpdate.newLatLngBounds(mapBounds, 20);
  }
}
