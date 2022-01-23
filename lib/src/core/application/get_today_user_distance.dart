import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/utils/date_custom_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodayUserDistance {
  final RouteModel _routeModel;
  final AuthenticationService _authService;
  GetTodayUserDistance(this._routeModel, this._authService);

  Future<double> execute() async {
    UserData? user = _authService.currentUserData;
    if (user == null) return Future.value(0);
    final DateTime now = DateTime.now();
    final Timestamp todayTimestamp = DateCustomUtils.convertDatetimeToTimestamp(
        DateTime(now.year, now.month, now.day));
    final List<RouteData> routes =
        await _routeModel.getRoutesbyDateAndUserId(todayTimestamp, user.id);
    return checkTodaysDistance(routes);
  }

  double checkTodaysDistance(List<RouteData> routes) {
    double distance = 0;
    for (var element in routes) {
      distance += element.distance!;
    }
    return distance;
  }
}
