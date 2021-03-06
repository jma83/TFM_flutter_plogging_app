import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/loading_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/login_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginPageViewModel extends AuthPropertyChangeNotifier {
  String _email = "";
  String _password = "";
  String _errorMessage = "";

  final UserViewModel _userViewModel;
  final LoadingService _loadingService;

  LoginPageViewModel(_authenticationService, this._userViewModel,
      this._loadingService, GetUserById _getUserById)
      : super(_authenticationService, _getUserById) {
    createAuthListener();
  }

  void validateForm() {
    toggleLoading(loading: true);
    if (!_userViewModel.validateLogin(_email, _password)) {
      setError(_userViewModel.errorMessage);
      return;
    }
    validationOkResponse();
  }

  Future<void> validationOkResponse() async {
    try {
      final String? result =
          await authService.signIn(email: _email, password: _password);
      if (result != null) {
        setError(result);
        return toggleLoading(loading: false);
      }
    } catch (_) {
      setError(
          "Sorry there was an error during login. Please try again later.");
      return toggleLoading(loading: false);
    }
    _loadingService.setLoading(true);
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    notifyListeners(LoginNotifiers.loginProcessError);
    toggleLoading(loading: false);
  }

  toggleLoading({bool loading = false}) {
    _loadingService.setLoading(loading);
  }

  @override
  notifyLoggedIn() {
    notifyListeners(LoginNotifiers.navigateToHome);
  }

  void manageRegisterNavigation() {
    notifyListeners(LoginNotifiers.navigateToRegister);
  }

  void dismissAlert() {
    notifyListeners(LoginNotifiers.navigateToPrevious);
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  get errorMessage {
    return _errorMessage;
  }

  get isLoading {
    return _loadingService.isLoading;
  }

  get email {
    return _email;
  }

  get password {
    return _password;
  }
}
