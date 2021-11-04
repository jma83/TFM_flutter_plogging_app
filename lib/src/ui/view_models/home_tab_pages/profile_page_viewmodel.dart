import 'package:flutter_plogging/src/ui/view_models/auth_property_change_notifier.dart';

class ProfilePageViewModel extends AuthPropertyChangeNotifier {
  ProfilePageViewModel(authenticationService) : super(authenticationService) {
    createAuthListener();
  }

  delayedLogoutProfile() {
    Future.delayed(const Duration(seconds: 1), () {
      authService.signOut();
    });
  }

  @override
  void notifyNotLoggedIn() {
    notifyListeners("profileRouteCoordinator_navigateToLogin");
  }
}
