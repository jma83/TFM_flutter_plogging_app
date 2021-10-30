import 'package:injectable/injectable.dart';

@injectable
abstract class IAuthenticationService {
  Future<String?> signIn({required String email, required String password});
  Future<String?> signUp({required String email, required String password});
  Future<String?> signOut();
}
