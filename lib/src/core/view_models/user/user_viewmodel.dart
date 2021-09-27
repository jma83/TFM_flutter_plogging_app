import 'package:flutter/foundation.dart';
import 'package:flutter_plogging/src/core/view_models/entities/user/user_viewmodel_strategies.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserViewModel extends ChangeNotifier {
  bool _valid = false;
  String _errorMessage = "";

  void validateLogin(String email) {
    final emailValidation = UserEmailStrategy();
    executeValidation(emailValidation, email);
    notifyListeners();
  }

  void validateRegister(String email, String username, String password1,
      String password2, int age, String gender) {
    List<UserViewModelStrategy> strategies = [
      UserEmailStrategy(),
      UserNameStrategy(),
      UserPasswordStrategy(),
      UserAgeStrategy(),
      UserGenderStrategy()
    ];
    List<String> values = [email, username, password1, age.toString(), gender];
    _valid = true;
    for (UserViewModelStrategy element in strategies) {
      int index = strategies.indexOf(element);
      executeValidation(element, values[index]);
      if (!_valid) {
        break;
      }
    }
    validateConfirmPasswords(password1, password2);
    notifyListeners();
  }

  void executeValidation(UserViewModelStrategy strategy, String value) {
    strategy.execute(value);
    if (!strategy.isApply()) {
      _valid = false;
      _errorMessage = strategy.getErrorMessage();
    }
  }

  void validateConfirmPasswords(String password1, String password2) {
    if (_valid) {
      final equalPasswords = UserPasswordsEquals();
      if (!equalPasswords.validate(password1, password2)) {
        _valid = false;
        _errorMessage = equalPasswords.getErrorMessage();
      }
    }
  }

  get errorMessage {
    return _errorMessage;
  }

  get valid {
    return _valid;
  }
}
