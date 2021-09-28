import 'package:flutter_plogging/src/ui/view_models/entities/user/user_viewmodel.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/login_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class LoginPageViewModel extends PropertyChangeNotifier<String> {
  String _email = "";
  String _password = "";

  final UserViewModel _userViewModel;
  final LoginPageRouteCoordinator _routeCoordinator;

  LoginPageViewModel(this._routeCoordinator, this._userViewModel);

  void validateForm() {
    _userViewModel.addListener(validationOkResponse, ["valid_login"]);
    _userViewModel.addListener(validationErrorResponse, ["invalid_login"]);
    _userViewModel.validateLogin(_email, _password);
  }

  void validationOkResponse() {
    // call db
  }

  void validationErrorResponse() {
    notifyListeners("invalid_login");
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
    return _userViewModel.errorMessage;
  }
}
