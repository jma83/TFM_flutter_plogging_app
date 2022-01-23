import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUser {
  UserModel userModel;
  AuthenticationService authenticationService;
  UpdateUser(this.userModel, this.authenticationService);

  Future<String?> execute(String id, UserData user,
      {String? email, String? password}) async {
    String? result;
    try {
      if (email != null && email != authenticationService.currentUser!.email) {
        result = await authenticationService.updateEmail(email: email);
      }
      if (password != null &&
          password != authenticationService.currentUser!.email) {
        result = await authenticationService.updatePassword(password: password);
      }
      if (result == null) {
        await userModel.updateElement(id, user);
      }
    } catch (_) {
      rethrow;
    }
    return result;
  }
}
