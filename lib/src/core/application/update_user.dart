import 'package:flutter_plogging/src/core/domain/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUser {
  UserModel userModel;
  UpdateUser(this.userModel);

  Future<void> execute(String id, UserData user) async {
    return await userModel.updateElement(id, user);
  }
}
