import 'package:flutter_plogging/src/core/domain/like/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/utils/iterable_utils.dart';
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
    final List<RouteData> routes = (await IterableUtils.requestProgressiveIn(
            _routeModel,
            likes.map((e) => e.routeId).toList(),
            RouteFieldData.id))
        .map((e) => e as RouteData)
        .toList();
    if (routes.isEmpty) return [];
    return RouteListData.createListFromRoutesAndLikes(routes, likes);
  }
}
