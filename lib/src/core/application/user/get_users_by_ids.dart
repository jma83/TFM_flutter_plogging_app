import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/utils/iterable_utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersByIds {
  final UserModel _userModel;

  GetUsersByIds(this._userModel);

  Future<List<UserData>> execute(List<String> ids) async {
    return (await IterableUtils.requestProgressiveIn(
            _userModel, ids, UserFieldData.id))
        .map((e) => e as UserData)
        .toList();
  }
}
