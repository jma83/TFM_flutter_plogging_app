import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class LoginPageViewModel extends PropertyChangeNotifier<String> {
  String _email = "";
  String _password = "";
  String _errorMessage = "";

  final UserViewModel _userViewModel;
  final AuthenticationService _authenticationService;

  LoginPageViewModel(this._userViewModel, this._authenticationService);

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
        await _authenticationService.signIn(email: _email, password: _password);
    if (result != null) {
      _errorMessage = result;
      notifyListeners("error_signin");
    }
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
