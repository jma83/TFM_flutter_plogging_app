import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginPageViewModel extends AuthPropertyChangeNotifier {
  String _email = "";
  String _password = "";
  String _errorMessage = "";
  bool _isLoading = false;

  final UserViewModel _userViewModel;

  LoginPageViewModel(
      _authenticationService, this._userViewModel, _userStoreService)
      : super(_authenticationService, _userStoreService) {
    createAuthListener();
  }

  void validateForm() {
    toggleLoading();
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
        return;
      }
    } catch (e) {
      print(e);
    }
    toggleLoading();
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    notifyListeners("error_signin");
    toggleLoading();
  }

  toggleLoading() {
    _isLoading ? EasyLoading.dismiss() : EasyLoading.show(status: 'loading...');
    _isLoading = !_isLoading;
  }

  @override
  notifyLoggedIn() {
    notifyListeners("loginRouteCoordinator_navigateToHome");
  }

  void manageRegisterNavigation() {
    notifyListeners("loginRouteCoordinator_navigateToRegister");
  }

  void dismissAlert() {
    notifyListeners("loginRouteCoordinator_returnToPrevious");
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
    return _isLoading;
  }
}
