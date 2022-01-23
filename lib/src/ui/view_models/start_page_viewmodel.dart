import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/notifiers/start_notifiers.dart';
import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends AuthPropertyChangeNotifier {
  StartPageViewModel(
      AuthenticationService _authService, GetUserById _getUserById)
      : super(_authService, _getUserById);

  void checkUserRedirection() {
    createAuthListener("START PAGE");
  }

  @override
  notifyLoggedIn() {
    notifyListeners(StartNotifiers.navigateToHome);
  }

  @override
  notifyNotLoggedIn() {
    notifyListeners(StartNotifiers.navigateToLogin);
  }
}
