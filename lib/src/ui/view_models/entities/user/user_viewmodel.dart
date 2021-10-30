import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel_strategies.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class UserViewModel extends PropertyChangeNotifier<String> {
  String _errorMessage = "";

  bool validateLogin(String email, String password) {
    return executeValidation(UserEmailStrategy(), email);
  }

  bool validateRegister(String email, String username, String password1,
      String password2, String age, String gender) {
    bool valid = false;
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
      valid = executeValidation(element, values[index]);
      if (!valid) {
        return false;
      }
    }
    return validateConfirmPasswords(password1, password2);
  }

  bool validateConfirmPasswords(String password1, String password2) {
    final equalPasswords = UserPasswordsEquals();
    if (!equalPasswords.validate(password1, password2)) {
      _errorMessage = equalPasswords.getErrorMessage();
      return false;
    }
    return true;
  }

  bool executeValidation(UserViewModelStrategy strategy, String value) {
    strategy.execute(value);
    if (strategy.emptyResult) {
      _errorMessage = strategy.getEmptyMessage();
      return false;
    }
    if (!strategy.validResult) {
      _errorMessage = strategy.getErrorMessage();
      return false;
    }
    return true;
  }

  get errorMessage {
    return _errorMessage;
  }
}
