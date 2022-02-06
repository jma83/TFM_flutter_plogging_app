import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_plogging/src/core/domain/like/like_data.dart';
import 'package:flutter_plogging/src/core/domain/route/route_list_data.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/uuid_generator_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class ManageLikeRoute {
  final LikeModel _likeModel;
  final UuidGeneratorService _uuidGeneratorService;
  final AuthenticationService _authenticationService;
  ManageLikeRoute(
      this._likeModel, this._uuidGeneratorService, this._authenticationService);

  void execute(RouteListData routeData, Function updatePageCallback) {
    routeData.isLiked = !routeData.isLiked;
    updatePageCallback();

    !routeData.isLiked
        ? _removeLikeFromRoute(routeData)
        : _addLikeToRoute(routeData);
  }

  _removeLikeFromRoute(RouteListData routeData) async {
    String id = routeData.likeId!;
    routeData.likeId = null;
    await _likeModel.removeElement(id);
  }

  _addLikeToRoute(RouteListData routeData) async {
    final String likeId = _uuidGeneratorService.generate();
    routeData.likeId = likeId;
    final newLike = LikeData(
        userId: _authenticationService.currentUser!.uid,
        routeId: routeData.id!,
        id: likeId,
        creationDate: Timestamp.now());
    await _likeModel.addElement(newLike);
  }
}
