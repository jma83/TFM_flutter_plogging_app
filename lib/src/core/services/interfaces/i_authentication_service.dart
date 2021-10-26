import 'package:injectable/injectable.dart';

@injectable
abstract class IAuthenticationService {
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({required String email, required String password});
  Future<void> signOut();
  final String errorSignIn = "";
  final String errorSignUp = "";
  final String errorSignOut = "";
}
