import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends AuthPropertyChangeNotifier {
  StartPageViewModel(_authService) : super(_authService);

  void checkUserRedirection() {
    Future.delayed(const Duration(seconds: 1), () => createAuthListener());
  }

  @override
  notifyLoggedIn() {
    notifyListeners("startRouteCoordinator_navigateToHome");
  }

  @override
  notifyNotLoggedIn() {
    notifyListeners("startRouteCoordinator_navigateToLogin");
  }
}
