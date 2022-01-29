import 'package:flutter_plogging/src/utils/regex_validator.dart';

const usernamePattern = r"^[a-zA-Z0-9_]{2,20}$";
const passwordPattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{3,30}$";
const emailPattern = r"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,30}";
const genderPattern = "[0-9]{1,1}";
const agePattern = "[0-9]{1,3}";
const empty = "Fields can't be empty. Please complete them and try again";

abstract class UserViewModelStrategy {
  bool validResult = false;
  bool emptyResult = false;
  bool detailError = true;
  UserViewModelStrategy(
      {this.validResult = false,
      this.emptyResult = false,
      this.detailError = true});
  void execute(String value);
  String getEmptyMessage();
  String getErrorMessage();
}

class UserEmailStrategy extends UserViewModelStrategy {
  @override
  void execute(String value) {
    emptyResult = value.isEmpty;
    validResult = RegexValidator.matchRegex(emailPattern, value);
  }

  @override
  String getErrorMessage() {
    return "Error, email format is incorrect.";
  }

  @override
  String getEmptyMessage() {
    return "Email can't be empty";
  }
}

class UserPasswordStrategy extends UserViewModelStrategy {
  UserPasswordStrategy({detailError = true}) : super(detailError: detailError);
  @override
  void execute(String value) {
    emptyResult = value.isEmpty;
    validResult = RegexValidator.matchRegex(passwordPattern, value);
  }

  @override
  String getErrorMessage() {
    return detailError
        ? "Error, password format is incorrect. Must contain at least an uppercase, a lowercase and a number."
        : "Invalid credentials";
  }

  @override
  String getEmptyMessage() {
    return "Password can't be empty";
  }
}

class UserNameStrategy extends UserViewModelStrategy {
  @override
  void execute(String value) {
    emptyResult = value.isEmpty;
    validResult = RegexValidator.matchRegex(usernamePattern, value);
  }

  @override
  String getErrorMessage() {
    return detailError
        ? "Error, the username format is incorrect. Must contain between 2 and 20 alphanumeric characters."
        : "Error username is invalid";
  }

  @override
  String getEmptyMessage() {
    return "Password can't be empty";
  }
}

class UserAgeStrategy extends UserViewModelStrategy {
  @override
  void execute(String value) {
    emptyResult = value.isEmpty;
    validResult = int.tryParse(value) != null &&
        RegexValidator.matchRegex(agePattern, value);
  }

  @override
  String getErrorMessage() {
    return detailError
        ? "Error, age is invalid. Must be greater or equals than 12 years old."
        : "Error, age is invalid";
  }

  @override
  String getEmptyMessage() {
    return "Age can't be empty";
  }
}

class UserGenderStrategy extends UserViewModelStrategy {
  @override
  void execute(String value) {
    emptyResult = value.isEmpty;
    validResult = RegexValidator.matchRegex(genderPattern, value);
  }

  @override
  String getErrorMessage() {
    return "Error, the gender format is incorrect. Choose within the available options.";
  }

  @override
  String getEmptyMessage() {
    return "Gender can't be empty";
  }
}

class UserPasswordsEquals {
  bool validate(String password1, String password2) {
    return password1 == password2;
  }

  String getErrorMessage() {
    return "Error, passwords don't match. Please, try again.";
  }
}
