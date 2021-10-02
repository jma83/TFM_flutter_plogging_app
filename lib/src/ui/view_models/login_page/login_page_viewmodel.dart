import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class LoginPageViewModel extends PropertyChangeNotifier<String> {
  String _email = "";
  String _password = "";
  String _errorMessage = "";

  final UserViewModel _userViewModel;
  final LoginPageRouteCoordinator _routeCoordinator;
  final AuthenticationService _authenticationService;

  LoginPageViewModel(this._routeCoordinator, this._userViewModel,
      this._authenticationService) {
    _userViewModel.addListener(validationOkResponse, ["valid_login"]);
    _userViewModel.addListener(validationErrorResponse, ["invalid_login"]);
    _authenticationService
        .addListener(validationErrorResponse, ["errorSignIn"]);
  }

  void validateForm() {
    _userViewModel.validateLogin(_email, _password);
  }

  Future<void> validationOkResponse() async {
    _authenticationService.signIn(email: _email, password: _password);
  }

  void validationErrorResponse() {
    _errorMessage = _userViewModel.errorMessage;
    notifyListeners("error_signin");
  }

  void signInErrorResponse() {
    _errorMessage = _authenticationService.errorSignIn;
    notifyListeners("error_signin");
  }

  void manageRegisterNavigation() {
    _routeCoordinator.navigateToRegister();
  }

  void dismissAlert() {
    _routeCoordinator.returnToPrevious();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  get valid {
    _userViewModel.valid;
  }

  get errorMessage {
    return _errorMessage;
  }
}
