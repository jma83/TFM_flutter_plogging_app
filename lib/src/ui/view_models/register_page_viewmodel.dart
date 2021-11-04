// ignore_for_file: constant_identifier_names
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/core/domain/user_entity.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
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
class RegisterPageViewModel extends AuthPropertyChangeNotifier {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _age = "";
  String _gender = Gender.NotDefined;
  String _errorMessage = "";
  bool _isLoading = false;

  final UserViewModel _userViewModel;
  final IStoreService _userStoreService;

  RegisterPageViewModel(
      authService, this._userViewModel, this._userStoreService)
      : super(authService) {
    print("RegisterPageViewModel");
    createAuthListener();
  }

  void validateForm() {
    toggleLoading();
    if (!_userViewModel.validateRegister(_email, _username, _password,
        _confirmPassword, _age, getGenderIndex().toString())) {
      setError(_userViewModel.errorMessage);
      return;
    }
    validationOkResponse();
  }

  void validationOkResponse() async {
    try {
      final String? result =
          await authService.signUp(email: _email, password: _password);
      if (result != null) {
        setError(result);
        return;
      }
    } catch (e) {
      print(e);
    }
    toggleLoading();
    /* await _userStoreService
        .addElement(User(_username, int.parse(_age), getGenderIndex())); */
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    notifyListeners("error_signup");
    toggleLoading();
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

  @override
  notifyLoggedIn() {
    notifyListeners("loginRouteCoordinator_navigateToHome");
  }

  void dismissAlert() {
    notifyListeners("loginRouteCoordinator_returnToPrevious");
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

  get errorMessage {
    return _errorMessage;
  }
}
