import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserImage {
  final UserModel _userModel;
  final AuthenticationService _authenticationService;
  UpdateUserImage(this._userModel, this._authenticationService);

  Future<void> execute(String image) async {
    final UserData user = _authenticationService.currentUserData!;
    await _userModel.setAndSaveImage(user.id, user, image);
    _authenticationService.currentUserData =
        await _userModel.queryElementById(user.id);
  }
}
