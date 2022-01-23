// ignore_for_file: must_call_super

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/application/get_user_by_id.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class AuthPropertyChangeNotifier extends PropertyChangeNotifier<String> {
  StreamSubscription<User?>? subscription;
  final AuthenticationService authService;
  final GetUserById getUserById;
  bool updated = false;
  String pepe = "";

  AuthPropertyChangeNotifier(this.authService, this.getUserById);

  void createAuthListener(String pepe) {
    this.pepe = pepe;
    subscription = authService.authStateChanges().listen((User? user) async {
      if (updated) {
        return;
      }

      if (authService.currentUser?.uid != user?.uid) {
        updated = true;
        subscription?.cancel();
      }

      if (user == null) {
        authService.currentUserData = null;
        Future.delayed(const Duration(seconds: 1), () => notifyNotLoggedIn());
        return;
      }
      authService.currentUserData = await getUserById.execute(user.uid);

      notifyLoggedIn();
    });
  }

  // Implements on child
  void notifyLoggedIn() {}
  void notifyNotLoggedIn() {}

  @override
  void dispose() {}
}
