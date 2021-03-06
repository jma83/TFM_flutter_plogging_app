import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserById {
  final UserModel _userModel;

  GetUserById(this._userModel);

  Future<UserData?> execute(String id) async {
    try {
      return await _userModel.queryElementById(id);
    } catch (_) {
      rethrow;
    }
  }
}
