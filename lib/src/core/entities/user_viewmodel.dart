class UserViewModel {
  void validate(String email, String username, String password1,
      String password2, int age, String gender) {
    validateEmail(email);
    validateUsername(username);
    validatePasswords(password1, password2);
    validatePasswordFormat(password1);
    validateAge(age);
    validateGender(gender);
  }

  void validateEmail(String email) {}
  void validateUsername(String username) {}
  void validatePasswords(String password1, String password2) {}
  void validatePasswordFormat(String password) {}
  void validateAge(int age) {}
  void validateGender(String gender) {}
}
