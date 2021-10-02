// ignore_for_file: constant_identifier_names
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/register_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

abstract class Gender {
  static const NotDefined = "Gender - Not defined";
  static const Female = "Female";
  static const Male = "Male";

  static const NotDefinedIndex = 0;
  static const FemaleIndex = 1;
  static const MaleIndex = 2;
}

@injectable
class RegisterPageViewModel extends PropertyChangeNotifier<String> {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _age = "";
  String _gender = Gender.NotDefined;
  String _errorMessage = "";

  final UserViewModel _userViewModel;
  final RegisterPageRouteCoordinator _routeCoordinator;
  final AuthenticationService _authenticationService;
  RegisterPageViewModel(this._routeCoordinator, this._userViewModel,
      this._authenticationService) {
    _userViewModel.addListener(validationOkResponse, ["valid_register"]);
    _userViewModel.addListener(validationErrorResponse, ["invalid_register"]);
    _authenticationService.addListener(signUpErrorResponse, ["errorSignUp"]);
  }
  void validateForm() {
    _userViewModel.validateRegister(_email, _username, _password,
        _confirmPassword, _age, getGenderIndex().toString());
  }

  void validationOkResponse() {
    _authenticationService.signUp(email: _email, password: _password);
  }

  void validationErrorResponse() {
    _errorMessage = _userViewModel.errorMessage;
    notifyListeners("error_signup");
  }

  void signUpErrorResponse() {
    _errorMessage = _authenticationService.errorSignUp;
    notifyListeners("error_signup");
  }

  getGenderIndex() {
    switch (_gender) {
      case Gender.NotDefined:
        return Gender.NotDefinedIndex;
      case Gender.Female:
        return Gender.FemaleIndex;
      case Gender.Male:
        return Gender.MaleIndex;
      default:
        return -1;
    }
  }

  void dismissAlert() {
    _routeCoordinator.returnToPrevious();
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

  void setAge(String age) {
    _age = age;
  }

  void setGender(String gender) {
    _gender = gender;
  }

  get gender {
    return _gender;
  }

  get valid {
    _userViewModel.valid;
  }

  get errorMessage {
    return _errorMessage;
  }
}
