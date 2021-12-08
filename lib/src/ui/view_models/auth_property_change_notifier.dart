import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/services/user_store_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class AuthPropertyChangeNotifier extends PropertyChangeNotifier<String> {
  StreamSubscription<User?>? subscription;
  final AuthenticationService authService;
  final UserStoreService userStoreService;

  AuthPropertyChangeNotifier(this.authService, this.userStoreService);

  void createAuthListener() {
    subscription = authService.authStateChanges.listen((User? user) async {
      if (user == null) {
        authService.setCurrentUserData(null);
        Future.delayed(const Duration(seconds: 1), () => notifyNotLoggedIn());
        return;
      }
      authService.setCurrentUserData(
          await userStoreService.queryElementById(user.uid));
      notifyLoggedIn();
    });
  }

  // Implements on child
  void notifyLoggedIn() {}
  void notifyNotLoggedIn() {}

  @override
  void dispose() {
    print("Dispose!!!!!!");
    super.dispose();
    subscription?.cancel();
  }
}
