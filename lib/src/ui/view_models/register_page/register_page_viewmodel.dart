import 'package:flutter/foundation.dart';
import 'package:flutter_plogging/src/ui/view_models/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/register_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';

enum Gender { NotDefined, Female, Male }

@injectable
class RegisterPageViewModel extends ChangeNotifier {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  int _age = 0;
  Gender _gender = Gender.NotDefined;

  final UserViewModel _userViewModel;
  final RegisterPageRouteCoordinator _routeCoordinator;
  RegisterPageViewModel(this._routeCoordinator, this._userViewModel);
  void validateForm() {
    if (_email.isEmpty ||
        _username.isEmpty ||
        _password.isEmpty ||
        _confirmPassword.isEmpty) {
      return;
    }
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  void setAge(int age) {
    _age = age;
  }

  void setGender(Gender gender) {
    _gender = gender;
  }
}
