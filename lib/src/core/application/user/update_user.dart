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
      {String? email, String? oldPassword, String? newPassword}) async {
    String? result;
    try {
      if (email != null && email != authenticationService.currentUser!.email) {
        if (oldPassword == null) {
          return "Email update needs also old password";
        }
        result = await authenticationService.updateEmail(
            email: email, password: oldPassword);
      }
      if (result == null && oldPassword != null && newPassword != null) {
        result = await authenticationService.updatePassword(
            newPassword: newPassword, oldPassword: oldPassword);
      }
      if (result == null) {
        await userModel.updateElement(id, user);
      }
    } catch (_) {
      return "Error. User update failed. Please, try again later";
    }
    return result;
  }
}
