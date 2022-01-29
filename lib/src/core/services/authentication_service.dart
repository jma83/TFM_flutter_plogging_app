// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/domain/auth/auth_error_data.dart';
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
  Future<String?> updateEmail(
      {required String email, required String password}) async {
    if (currentUser == null) return null;
    try {
      await _reauthenticate(password);
      await currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    }
    return null;
  }

  @override
  Future<String?> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    if (currentUser == null) return null;
    try {
      await _reauthenticate(oldPassword);
      await currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      return _getMessageFromErrorCode(e.code);
    }
    return null;
  }

  Future<UserCredential> _reauthenticate(String currentPassword) async {
    final AuthCredential cred = EmailAuthProvider.credential(
        email: currentUser!.email!, password: currentPassword);
    try {
      return await currentUser!.reauthenticateWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  String _getMessageFromErrorCode(String errorCode) {
    String errorMsg = genericError;

    authErrorList.forEach((key, value) {
      if (key.contains(errorCode)) {
        errorMsg = value;
      }
    });
    return errorMsg;
  }
}
