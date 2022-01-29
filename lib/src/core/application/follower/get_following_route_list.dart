import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';
import 'package:flutter_plogging/src/core/domain/like/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/utils/iterable_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFollowingRouteList {
  final RouteModel _routeModel;
  final FollowerModel _followerModel;
  final LikeModel _likeModel;

  GetFollowingRouteList(this._followerModel, this._routeModel, this._likeModel);

  Future<List<RouteListData>> execute(String currentUserId) async {
    final List<String> userFollowingIds = await _getFollowingIds(currentUserId);
    final List<RouteData> userFollowingRoutes =
        await _getFollowingRoutes(userFollowingIds);
    final List<LikeData> likes =
        await _matchRoutesWithUserLikes(userFollowingRoutes, currentUserId);
    return RouteListData.createListFromRoutesAndLikes(
        userFollowingRoutes, likes);
  }

  Future<List<String>> _getFollowingIds(String currentUserId) async {
    final List<FollowerData> followers = await _followerModel
        .queryElementEqualByCriteria(FollowerFieldData.userId, currentUserId);

    return followers.map((e) => e.userFollowedId).toList();
  }

  Future<List<RouteData>> _getFollowingRoutes(
      List<String> userFollowingIds) async {
    if (userFollowingIds.isEmpty) {
      return [];
    }
    return (await IterableUtils.requestProgressiveIn(
            _routeModel, userFollowingIds, RouteFieldData.userId))
        .map((e) => e as RouteData)
        .toList();
  }

  Future<List<LikeData>> _matchRoutesWithUserLikes(
      List<RouteData> routes, String userId) async {
    if (routes.isEmpty) {
      return [];
    }

    return await IterableUtils.requestProgressiveInMatchLikes(
        _likeModel, routes.map((e) => e.id!).toList(), userId);
  }
}
