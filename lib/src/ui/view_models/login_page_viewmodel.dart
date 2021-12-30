import 'package:flutter_plogging/src/core/services/loading_service.dart';
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
      this._loadingService, _userStoreService)
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
        return toggleLoading();
      }
    } catch (e) {
      print(e);
      return toggleLoading();
    }
    _loadingService.setLoading(true);
  }

  setError(String errorValue) {
    _errorMessage = errorValue;
    notifyListeners("error_signin");
    toggleLoading();
  }

  toggleLoading() {
    _loadingService.toggleLoading();
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
    return _loadingService.isLoading;
  }
}
