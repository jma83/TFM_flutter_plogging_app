import 'dart:math';

class DistanceUtils {
  static const defaultMeassure = "meters";
  static const secondaryMeassure = "km";

  static double getDistanceFormat(double? distance) {
    if (distance == null) return 0;
    distance = checkMeassure(distance);
    num mod = pow(10.0, 2);
    return ((distance * mod).round().toDouble() / mod);
  }

  static double checkMeassure(double distance) {
    if (distance >= 1000) {
      distance = distance / 1000;
    }
    return distance;
  }

  static String getMeassure(double? distance) {
    if (distance == null) return defaultMeassure;
    if (checkMeassure(distance) == distance) {
      return defaultMeassure;
    }
    return secondaryMeassure;
  }
}
