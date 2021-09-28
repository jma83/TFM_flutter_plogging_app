import 'package:flutter/foundation.dart';
import 'package:flutter_plogging/src/ui/view_models/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginPageViewModel extends ChangeNotifier {
  String _email = "";
  String _password = "";

  final UserViewModel _userViewModel;
  final LoginPageRouteCoordinator _routeCoordinator;

  LoginPageViewModel(this._routeCoordinator, this._userViewModel);

  void validateForm() {
    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    _userViewModel.addListener(validateUserResponse);
    _userViewModel.validateLogin(_email);
  }

  void validateUserResponse() {
    if (_userViewModel.valid) {
      // Call db
    }
    notifyListeners();
  }

  void manageRegisterNavigation() {
    print("manageRegisterNavigation");
    _routeCoordinator.navigateToRegister();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  get valid {
    _userViewModel.valid();
  }

  get errorMessage {
    return _userViewModel.errorMessage();
  }
}
