import 'package:flutter_plogging/src/core/domain/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route_data.dart';
import 'package:flutter_plogging/src/core/domain/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/model/route_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRouteListById {
  final RouteModel _routeModel;
  final LikeModel _likeModel;
  final AuthenticationService _authenticationService;

  GetRouteListById(
      this._routeModel, this._likeModel, this._authenticationService);
  Future<RouteListData?> execute(String routeId) async {
    final RouteData? route = await _getRoute(routeId);
    if (route == null) return null;
    final LikeData? like = await _getRouteIdWithLike(
        _authenticationService.currentUser!.uid, route);

    return RouteListData(
        routeData: route, likeId: like?.id, isLiked: like != null);
  }

  Future<RouteData?> _getRoute(String routeId) async {
    return await _routeModel.queryElementById(routeId);
  }

  Future<LikeData?> _getRouteIdWithLike(
      String userId, RouteData routeData) async {
    return (await _likeModel.matchRoutesWithUserLikes(userId, [routeData.id!]))
        .first;
  }
}
