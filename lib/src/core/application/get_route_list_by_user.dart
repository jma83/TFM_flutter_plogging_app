import 'package:flutter_plogging/src/core/domain/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRouteListByUser {
  final RouteModel _routeModel;
  final LikeModel _likeModel;

  GetRouteListByUser(this._routeModel, this._likeModel);
  Future<List<RouteListData>> execute(String userId) async {
    final List<RouteData> routes = await _getRoutes(userId);
    if (routes.isEmpty) return [];
    final List<LikeData> likes = await _getRouteIdsWithLike(userId);

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
