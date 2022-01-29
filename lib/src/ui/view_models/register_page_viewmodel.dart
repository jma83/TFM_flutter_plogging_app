// ignore_for_file: constant_identifier_names
import 'package:flutter_plogging/src/core/application/user/create_user.dart';
import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/domain/gender/gender_data.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/register_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterPageViewModel extends AuthPropertyChangeNotifier {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _age = "";
  String _gender = Gender.NotDefined;
  String _errorMessage = "";

  final LoadingService _loadingService;
  final UserViewModel _userViewModel;
  final CreateUser _createUser;

  RegisterPageViewModel(authService, this._userViewModel, this._loadingService,
      this._createUser, GetUserById getUserById)
      : super(authService, getUserById) {
    createAuthListener();
  }

  void validateForm() {
    toggleLoading(value: true);
    if (!_userViewModel.validateRegister(_email, _username, _password,
        _confirmPassword, _age, Gender.getGenderIndex(_gender).toString())) {
      setError(_userViewModel.errorMessage);
      return;
    }
    validationOkResponse();
  }

  void validationOkResponse() async {
    try {
      final String? result = await _createUser.execute(
          username: _username,
          age: int.parse(_age),
          gender: Gender.getGenderIndex(_gender),
          email: _email,
          password: _password);
      if (result != null) {
        setError(result);
        return;
      }
    } catch (_) {
      setError("Sorry, couldn't validate data. Please, try it again later");
    }
    toggleLoading(value: false);
  }

  toggleLoading({bool value = false}) {
    _loadingService.setLoading(value);
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    toggleLoading(value: false);
    notifyListeners(RegisterNotifiers.registerProcessError);
  }

  @override
  notifyLoggedIn() {
    notifyListeners(RegisterNotifiers.navigateToHome);
  }

  void dismissAlert() {
    notifyListeners(RegisterNotifiers.navigateToPrevious);
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

  get email {
    return _email;
  }

  get username {
    return _username;
  }

  get password {
    return _password;
  }

  get confirmPassword {
    return _confirmPassword;
  }

  get age {
    return _age;
  }

  get gender {
    return _gender;
  }

  get errorMessage {
    return _errorMessage;
  }
}
