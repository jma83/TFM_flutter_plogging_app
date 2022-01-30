import 'package:flutter_plogging/src/utils/app_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class RouteViewModel {
  String _errorMessage = "";

  bool _validateDistance(double distance) {
    final validationResult = AppConstants.minDistance <= distance;
    if (!validationResult) {
      _errorMessage =
          "Sorry. Distance must be greater than ${AppConstants.minDistance} meters";
    }
    return validationResult;
  }

  bool _validateDuration(int duration) {
    final validationResult = AppConstants.minDuration <= duration;
    if (!validationResult) {
      _errorMessage =
          "Sorry. Duration must be at least ${AppConstants.minDuration} seconds";
    }
    return validationResult;
  }

  bool _validateSpeed(double distance, int duration) {
    final validationResult = AppConstants.maxSpeed >= (distance / duration);
    if (!validationResult) {
      _errorMessage = "Sorry. Routes with vehicles are not allowed";
    }
    return validationResult;
  }

  bool validateRoute(double distance, int duration) {
    return _validateDistance(distance) &&
        _validateDuration(duration) &&
        _validateSpeed(distance, duration);
  }

  String get errorMessage {
    return _errorMessage;
  }
}
