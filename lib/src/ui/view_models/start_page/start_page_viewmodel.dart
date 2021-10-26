import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@injectable
class StartPageViewModel extends PropertyChangeNotifier<String> {
  final AuthenticationService _authService;
  StartPageViewModel(this._authService) {
    print("creoo viewmodel!");
  }

  void checkUserRedirection() {
    _authService.signOut();
    Future.delayed(
        const Duration(seconds: 1),
        () => _authService.authStateChanges.listen((User? user) {
              print("holaa! $user");
              if (user == null) {
                notifyListeners("startRouteCoordinator_navigateToLogin");
              } else {
                notifyListeners("startRouteCoordinator_navigateToHome");
              }
            }));
  }
}
