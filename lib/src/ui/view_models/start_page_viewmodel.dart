import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/start_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends AuthPropertyChangeNotifier {
  StartPageViewModel(
      AuthenticationService _authService, GetUserById _getUserById)
      : super(_authService, _getUserById);
  bool alreadyDisposed = false;

  void checkUserRedirection() {
    createAuthListener();
  }

  @override
  notifyLoggedIn() {
    if (alreadyDisposed) {
      return;
    }
    notifyListeners(StartNotifiers.navigateToHome);
  }

  @override
  notifyNotLoggedIn() {
    if (alreadyDisposed) {
      return;
    }
    notifyListeners(StartNotifiers.navigateToLogin);
  }

  @override
  void dispose() {
    super.dispose();
    alreadyDisposed = true;
  }
}
