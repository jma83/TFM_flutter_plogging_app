class LoginPageViewModel {
  late Function delegate;
  void validateForm(String? email, String? password) {
    if (email == null || password == null) {
      return;
    }
    if (email.isEmpty || password.isEmpty) {
      return;
    }
  }
}
