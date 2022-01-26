import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateUser {
  final UserModel _userModel;
  final AuthenticationService _authService;

  CreateUser(this._userModel, this._authService);

  Future<String?> execute(
      {required String username,
      required int age,
      required int gender,
      required String email,
      required String password}) async {
    try {
      final String? result =
          await _authService.signUp(email: email, password: password);
      await _userModel.addElement(UserData(
          id: _authService.currentUser!.uid,
          username: username,
          age: age,
          gender: gender));
      return result;
    } catch (_) {
      return "Error during registration. Please, try again later";
    }
  }
}
