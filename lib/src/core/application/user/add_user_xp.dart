import 'package:flutter_plogging/src/core/domain/route/route_data.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/utils/app_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddUserXp {
  final UserModel _userModel;
  final AuthenticationService _authService;
  AddUserXp(this._userModel, this._authService);

  Future<String?> execute(RouteData route) async {
    final UserData user = _authService.currentUserData!;
    int resultXp = _calcResultXp(route, user.xp);
    int countLevels = 0;

    while (resultXp >= _getRequiredXp(countLevels + user.level)) {
      resultXp = resultXp - _getRequiredXp(countLevels + user.level);
      countLevels++;
    }
    final UserData newUser = _getNewUserData(user, countLevels, resultXp);
    try {
      await _userModel.updateElement(user.id, newUser);
      _authService.currentUserData = newUser;
      return null;
    } catch (_) {
      return "Error when updating user level";
    }
  }

  int _calcResultXp(RouteData route, int currentXp) {
    final int earnedXp = (route.distance! *
            AppConstants.maxObjectiveXP /
            AppConstants.objectiveDistance)
        .round();
    final int bonusXp = route.image != null ? 2 : 1;
    return earnedXp * bonusXp + currentXp;
  }

  int _getRequiredXp(int level) {
    return level * AppConstants.incrementXP + AppConstants.baseXP;
  }

  UserData _getNewUserData(UserData user, int countLevels, int resultXp) {
    return UserData(
        id: user.id,
        username: user.username,
        age: user.age,
        gender: user.gender,
        followers: user.followers,
        following: user.following,
        image: user.image,
        level: user.level + countLevels,
        xp: resultXp,
        creationDate: user.creationDate);
  }
}
