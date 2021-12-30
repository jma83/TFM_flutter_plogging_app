import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';
import 'package:flutter_plogging/src/core/model/user_model.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class AuthPropertyChangeNotifier extends PropertyChangeNotifier<String> {
  StreamSubscription<User?>? subscription;
  final AuthenticationService authService;
  final UserModel userModel;

  AuthPropertyChangeNotifier(this.authService, this.userModel);

  void createAuthListener() {
    subscription = authService.authStateChanges.listen((User? user) async {
      if (user == null) {
        authService.setCurrentUserData(null);
        print("logout!!");

        Future.delayed(const Duration(seconds: 1), () => notifyNotLoggedIn());
        return;
      }
      print("login!!");

      authService
          .setCurrentUserData(await userModel.queryElementById(user.uid));
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
