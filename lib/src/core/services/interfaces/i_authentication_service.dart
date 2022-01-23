import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_plogging/src/core/domain/user/user_data.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IAuthenticationService {
  Future<String?> signIn({required String email, required String password});
  Future<String?> signUp({required String email, required String password});
  Future<String?> signOut();
  Future<String?> updateEmail({required String email});
  Future<String?> updatePassword({required String password});
  User? get currentUser;
  UserData? currentUserData;
}
