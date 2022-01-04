import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateUser {
  UserModel userModel;
  CreateUser(this.userModel);

  Future<void> execute(UserData user) async {
    return await userModel.addElement(user);
  }
}
