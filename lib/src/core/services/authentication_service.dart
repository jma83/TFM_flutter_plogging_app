import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  AuthenticationService(this._firebaseAuth);

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Sign in success!";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Sign up success!";
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message);
    }
  }
}
