import 'package:flutter_plogging/src/core/domain/like/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/utils/iterable_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchRouteList {
  final RouteModel _routeModel;
  final LikeModel _likeModel;

  SearchRouteList(this._routeModel, this._likeModel);
  Future<List<RouteListData>> execute(String value, String userId) async {
    final List<RouteData> routes = await _getRoutes(value, userId);
    if (routes.isEmpty) return [];
    final List<LikeData> likes = await _getRouteIdsWithLike(routes, userId);

    return RouteListData.createListFromRoutesAndLikes(routes, likes);
  }

  Future<List<RouteData>> _getRoutes(String value, String userId) async {
    return await _routeModel.searchRoutesByNameAndAuthor(value, userId);
  }

  Future<List<LikeData>> _getRouteIdsWithLike(
      List<RouteData> routes, String userId) async {
    return await IterableUtils.requestProgressiveInMatchLikes(
        _likeModel, routes.map((e) => e.id!).toList(), userId);
  }
}
