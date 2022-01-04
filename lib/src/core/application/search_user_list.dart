import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchUserList {
  final UserModel _userModel;
  SearchUserList(this._userModel);

  execute(String value) async {
    return await _userModel.queryElementLikeByCriteria(
        UserFieldData.username, value);
  }
}
