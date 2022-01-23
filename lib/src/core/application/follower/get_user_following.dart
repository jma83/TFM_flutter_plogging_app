import 'package:flutter_plogging/src/core/domain/follower/follower_data.dart';
import 'package:flutter_plogging/src/core/model/follower_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserFollowing {
  final FollowerModel _followerModel;
  GetUserFollowing(this._followerModel);
  Future<List<FollowerData>> execute(String currentUserId) async {
    return await _followerModel.queryElementEqualByCriteria(
        FollowerFieldData.userId, currentUserId);
  }
}
