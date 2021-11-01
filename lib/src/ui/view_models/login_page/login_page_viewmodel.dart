import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginPageViewModel extends AuthPropertyChangeNotifier {
  String _email = "";
  String _password = "";
  String _errorMessage = "";

  final UserViewModel _userViewModel;

  LoginPageViewModel(_authenticationService, this._userViewModel)
      : super(_authenticationService) {
    print("mountLoginPage!!!!!!!!!");
    createAuthListener();
  }

  void validateForm() {
    if (!_userViewModel.validateLogin(_email, _password)) {
      _errorMessage = _userViewModel.errorMessage;
      notifyListeners("error_signin");
      return;
    }
    validationOkResponse();
  }

  Future<void> validationOkResponse() async {
    final String? result =
        await authService.signIn(email: _email, password: _password);
    if (result != null) {
      _errorMessage = result;
      notifyListeners("error_signin");
    }
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
}
