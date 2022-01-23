import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateRoute {
  final RouteModel _routeModel;
  CreateRoute(this._routeModel);

  Future<void> execute(RouteData route) async {
    return await _routeModel.addElement(route);
  }
}
