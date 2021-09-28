import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/ui/route_coordinators/start_page_route_coordinator.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartPageViewModel extends ChangeNotifier {
  final AuthenticationService _authService;
  final StartPageRouteCoordinator _routeCoordinator;
  StartPageViewModel(this._routeCoordinator, this._authService);

  void checkUserRedirection() {
    _authService.signOut();
    Future.delayed(
        const Duration(seconds: 1),
        () => _authService.authStateChanges.listen((User? user) {
              if (user == null) {
                _routeCoordinator.navigateToLogin();
              } else {
                _routeCoordinator.navigateToHome();
              }
            }));
  }
}
