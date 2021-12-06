import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class AuthPropertyChangeNotifier extends PropertyChangeNotifier<String> {
  StreamSubscription<User?>? subscription;
  final AuthenticationService authService;

  AuthPropertyChangeNotifier(this.authService);

  void createAuthListener() {
    subscription = authService.authStateChanges.listen((User? user) {
      print("holaa! $user");
      if (user == null) {
        notifyNotLoggedIn();
        return;
      }
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
