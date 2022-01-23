import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserFollowers {
  final FollowerModel _followerModel;
  GetUserFollowers(this._followerModel);
  execute(String currentUserId) async {
    return await _followerModel.queryElementEqualByCriteria(
        FollowerFieldData.userFollowedId, currentUserId);
  }
}
