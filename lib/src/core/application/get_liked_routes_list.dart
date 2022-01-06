import 'package:flutter_plogging/src/core/domain/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLikedRoutesList {
  final LikeModel _likeModel;
  final RouteModel _routeModel;
  GetLikedRoutesList(this._routeModel, this._likeModel);

  Future<List<RouteListData>> execute(String userId) async {
    final List<LikeData> likes = await _likeModel.queryElementEqualByCriteria(
        LikeFieldData.userId, userId);
    if (likes.isEmpty) return [];
    final List<RouteData> routes = await _routeModel.queryElementInCriteria(
        RouteFieldData.id, likes.map((e) => e.routeId).toList());
    if (routes.isEmpty) return [];
    return RouteListData.createListFromRoutesAndLikes(routes, likes);
  }
}
