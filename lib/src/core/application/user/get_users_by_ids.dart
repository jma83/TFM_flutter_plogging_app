import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersByIds {
  final UserModel _userModel;

  GetUsersByIds(this._userModel);

  Future<List<UserData>> execute(List<String> ids) async {
    return await _userModel.queryElementInCriteria(UserFieldData.id, ids);
  }
}
