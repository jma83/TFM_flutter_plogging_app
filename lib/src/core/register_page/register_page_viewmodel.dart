import 'package:flutter/foundation.dart';

enum Gender { NotDefined, Female, Male }

class RegisterPageViewModel extends ChangeNotifier {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  int _age = 0;
  Gender _gender = Gender.NotDefined;

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
