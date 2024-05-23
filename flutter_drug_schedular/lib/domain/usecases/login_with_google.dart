
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithGoogle {
  final AuthRepository repository;

  LoginWithGoogle(this.repository);

  Future<User?> call() async {
    return await repository.loginWithGoogle();
  }
}
