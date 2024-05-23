
import 'package:flutter/material.dart';
import '../../domain/usecases/login_with_google.dart';

class AuthProvider with ChangeNotifier {
  final LoginWithGoogle loginWithGoogleUseCase;

  AuthProvider({required this.loginWithGoogleUseCase});

  Future<void> loginWithGoogle() async {
    await loginWithGoogleUseCase.call();
    notifyListeners();
  }
}
