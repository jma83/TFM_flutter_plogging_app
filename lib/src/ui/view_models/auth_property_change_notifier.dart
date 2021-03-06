import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/application/user/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class AuthPropertyChangeNotifier extends PropertyChangeNotifier<String> {
  StreamSubscription<User?>? subscription;
  final AuthenticationService authService;
  final GetUserById getUserById;

  AuthPropertyChangeNotifier(this.authService, this.getUserById);

  void createAuthListener() {
    subscription = authService.authStateChanges.listen((User? user) async {
      if (user == null) {
        authService.currentUserData = null;

        Future.delayed(const Duration(seconds: 1), () => notifyNotLoggedIn());
        return;
      }

      try {
        authService.currentUserData = await getUserById.execute(user.uid);
        notifyLoggedIn();
      } catch (_) {
        errorDuringLogin();
      }
    });
  }

  // Implements on child
  void notifyLoggedIn() {}
  void notifyNotLoggedIn() {}
  void errorDuringLogin() {}

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }
}
