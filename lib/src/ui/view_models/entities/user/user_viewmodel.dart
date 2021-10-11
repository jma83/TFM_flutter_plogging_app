import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel_strategies.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class UserViewModel extends PropertyChangeNotifier<String> {
  bool _valid = false;
  String _errorMessage = "";

  void validateLogin(String email, String password) {
    _valid = true;

    validateEmptyFields([email, password]);
    if (_valid) {
      executeValidation(UserEmailStrategy(), email);
    }
    _valid ? notifyListeners("valid_login") : notifyListeners("invalid_login");
  }

  void validateRegister(String email, String username, String password1,
      String password2, String age, String gender) {
    _valid = true;
    validateEmptyFields([email, username, password1, password2, age, gender]);
    if (_valid) {
      validateRegisterFields(
          email, username, password1, password2, age, gender);
    }
    if (_valid) {
      validateConfirmPasswords(password1, password2);
    }
    _valid
        ? notifyListeners("valid_register")
        : notifyListeners("invalid_register");
  }

  void validateRegisterFields(String email, String username, String password1,
      String password2, String age, String gender) {
    List<UserViewModelStrategy> strategies = [
      UserEmailStrategy(),
      UserNameStrategy(),
      UserPasswordStrategy(),
      UserAgeStrategy(),
      UserGenderStrategy()
    ];
    List<String> values = [email, username, password1, age, gender];
    for (UserViewModelStrategy element in strategies) {
      int index = strategies.indexOf(element);
      executeValidation(element, values[index]);
      if (!_valid) {
        break;
      }
    }
  }

  void validateConfirmPasswords(String password1, String password2) {
    final equalPasswords = UserPasswordsEquals();
    if (!equalPasswords.validate(password1, password2)) {
      _valid = false;
      _errorMessage = equalPasswords.getErrorMessage();
    }
  }

  void validateEmptyFields(List<String> fields) {
    for (String field in fields) {
      if (field.isEmpty) {
        _errorMessage =
            "Fields can't be empty. Please complete them and try again";
        _valid = false;
        break;
      }
    }
  }

  void executeValidation(UserViewModelStrategy strategy, String value) {
    strategy.execute(value);
    if (!strategy.isApply()) {
      _valid = false;
      _errorMessage = strategy.getErrorMessage();
    }
  }

  get errorMessage {
    return _errorMessage;
  }

  get valid {
    return _valid;
  }
}
