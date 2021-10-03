import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/services/interfaces/i_authentication_service.dart';
import 'package:injectable/injectable.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

@LazySingleton(as: IAuthenticationService)
class AuthenticationService extends PropertyChangeNotifier<String>
    implements IAuthenticationService {
  final FirebaseAuth _firebaseAuth;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  AuthenticationService(this._firebaseAuth);
  String _errorSignIn = "";
  String _errorSignUp = "";
  String _errorSignOut = "";

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        _errorSignIn = e.message!;
      }
      notifyListeners("errorSignIn");
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        _errorSignUp = e.message!;
      }
      notifyListeners("errorSignUp");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        _errorSignOut = e.message!;
      }
      notifyListeners("errorSignOut");
    }
  }

  @override
  get errorSignIn {
    return _errorSignIn;
  }

  @override
  get errorSignUp {
    return _errorSignUp;
  }

  @override
  get errorSignOut {
    return _errorSignOut;
  }
}
