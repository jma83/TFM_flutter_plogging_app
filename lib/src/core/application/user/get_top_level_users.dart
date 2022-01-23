import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTopLevelUsers {
  final UserModel _userModel;
  GetTopLevelUsers(this._userModel);

  Future<List<UserData>> execute() async {
    return await _userModel.getTopLevelUsers(10);
  }
}
