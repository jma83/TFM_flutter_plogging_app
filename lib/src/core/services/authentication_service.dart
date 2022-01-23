import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_authentication_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthenticationService)
class AuthenticationService implements IAuthenticationService {
  final FirebaseAuth _firebaseAuth;
  UserData? _userData;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  AuthenticationService(this._firebaseAuth);

  @override
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    }
    return null;
  }

  @override
  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    }
    return null;
  }

  @override
  Future<String?> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    }
    return null;
  }

  @override
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  @override
  UserData? get currentUserData {
    return _userData;
  }

  @override
  set currentUserData(UserData? currentUserData) {
    if (currentUser == null) {
      _userData = null;
      return;
    }
    _userData = currentUserData;
  }

  @override
  Future<String?> updateEmail({required String email}) async {
    if (currentUser == null) return null;
    try {
      await currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      return Future.error(_getMessageFromErrorCode(e.code));
    }
    return null;
  }

  @override
  Future<String?> updatePassword({required String password}) async {
    if (currentUser == null) return null;
    try {
      await currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      return Future.error(_getMessageFromErrorCode(e.code));
    }
    return null;
  }

  String _getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }
}
