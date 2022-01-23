import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateUser {
  final UserModel _userModel;
  CreateUser(this._userModel);

  Future<void> execute(UserData user) async {
    return await _userModel.addElement(user);
  }
}
