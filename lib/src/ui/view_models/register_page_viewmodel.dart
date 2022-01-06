// ignore_for_file: constant_identifier_names
import 'package:flutter_plogging/src/core/application/create_user.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/core/domain/user_data.dart';
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
    toggleLoading();
    if (!_userViewModel.validateRegister(_email, _username, _password,
        _confirmPassword, _age, Gender.getGenderIndex(_gender).toString())) {
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
      setError("Sorry, couldn't validate data. Please, try it again later");
      // ignore: avoid_print
      print(e);
    }
    toggleLoading();
    await _createUser.execute(UserData(
        id: authService.currentUser!.uid,
        username: _username,
        age: int.parse(_age),
        gender: Gender.getGenderIndex(_gender)));
  }

  toggleLoading() {
    _loadingService.toggleLoading();
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    toggleLoading();
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

  get gender {
    return _gender;
  }

  get errorMessage {
    return _errorMessage;
  }
}
