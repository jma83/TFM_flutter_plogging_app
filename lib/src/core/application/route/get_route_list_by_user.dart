import 'package:flutter_plogging/src/core/domain/like/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRouteListByUser {
  final RouteModel _routeModel;
  final LikeModel _likeModel;
  final AuthenticationService _authenticationService;

  GetRouteListByUser(
      this._routeModel, this._likeModel, this._authenticationService);
  Future<List<RouteListData>> execute(String userId) async {
    final List<RouteData> routes = await _getRoutes(userId);
    if (routes.isEmpty) return [];
    final List<LikeData> likes =
        await _getRouteIdsWithLike(_authenticationService.currentUser!.uid);

    return RouteListData.createListFromRoutesAndLikes(routes, likes);
  }

  Future<List<RouteData>> _getRoutes(String userId) async {
    return await _routeModel.queryElementEqualByCriteria(
        RouteFieldData.userId, userId);
  }

  Future<List<LikeData>> _getRouteIdsWithLike(String userId) async {
    return await _likeModel.queryElementEqualByCriteria(
        LikeFieldData.userId, userId);
  }
}
