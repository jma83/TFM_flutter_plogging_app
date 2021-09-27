import 'package:flutter/foundation.dart';

class LoginPageViewModel extends ChangeNotifier {
  String _email = "";
  String _password = "";

  void validateForm() {
    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    print("notify!!!");
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }
}
