import 'package:flutter_plogging/src/core/domain/follower_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckUserFollowed {
  final AuthenticationService _authenticationService;
  final FollowerModel _followerModel;
  CheckUserFollowed(this._followerModel, this._authenticationService);
  Future<FollowerData?> execute(String userId) async {
    return await _followerModel.isUserFollowed(
        _authenticationService.currentUser!.uid, userId);
  }
}
