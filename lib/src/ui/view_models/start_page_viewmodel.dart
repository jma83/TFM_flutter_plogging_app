import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends AuthPropertyChangeNotifier {
  StartPageViewModel(_authService, _userStoreService)
      : super(_authService, _userStoreService);
  bool alreadyDisposed = false;

  void checkUserRedirection() {
    createAuthListener();
  }

  @override
  notifyLoggedIn() {
    if (alreadyDisposed) {
      return;
    }
    notifyListeners("startRouteCoordinator_navigateToHome");
  }

  @override
  notifyNotLoggedIn() {
    if (alreadyDisposed) {
      return;
    }
    notifyListeners("startRouteCoordinator_navigateToLogin");
  }

  @override
  void dispose() {
    super.dispose();
    alreadyDisposed = true;
  }
}
