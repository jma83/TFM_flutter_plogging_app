import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends AuthPropertyChangeNotifier {
  StartPageViewModel(_authService) : super(_authService);
  bool alreadyDisposed = false;

  void checkUserRedirection() {
    Future.delayed(const Duration(seconds: 1), () {
      createAuthListener();
    });
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
    print("Dispose!!!!!!");
    super.dispose();
    alreadyDisposed = true;
  }
}
