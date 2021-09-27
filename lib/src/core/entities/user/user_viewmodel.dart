import 'package:flutter/foundation.dart';
import 'package:flutter_plogging/src/core/entities/user/user_viewmodel_strategies.dart';

class UserViewModel extends ChangeNotifier {
  bool valid = false;
  String errorMessage = "";

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
    valid = true;
    for (UserViewModelStrategy element in strategies) {
      int index = strategies.indexOf(element);
      executeValidation(element, values[index]);
      if (!valid) {
        break;
      }
    }
    validateConfirmPasswords(password1, password2);
    notifyListeners();
  }

  void executeValidation(UserViewModelStrategy strategy, String value) {
    strategy.execute(value);
    if (!strategy.isApply()) {
      valid = false;
      errorMessage = strategy.getErrorMessage();
    }
  }

  void validateConfirmPasswords(String password1, String password2) {
    if (valid) {
      final equalPasswords = UserPasswordsEquals();
      if (!equalPasswords.validate(password1, password2)) {
        valid = false;
        errorMessage = equalPasswords.getErrorMessage();
      }
    }
  }
}
