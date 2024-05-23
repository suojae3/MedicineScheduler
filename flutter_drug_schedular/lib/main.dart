import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/pill_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/pill_repository_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/services/firebase_service.dart';
import 'domain/usecases/add_user.dart';
import 'domain/usecases/get_user.dart';
import 'domain/usecases/add_pill.dart';
import 'domain/usecases/get_pills.dart';
import 'domain/usecases/login_with_google.dart';
import 'presentation/pages/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  final firebaseService = FirebaseService();
  final userRepository = UserRepositoryImpl(firebaseService.firestore);
  final pillRepository = PillRepositoryImpl(firebaseService.firestore);
  final authRepository = AuthRepositoryImpl(firebaseService.auth, GoogleSignIn());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            addUserUseCase: AddUser(userRepository),
            getUserUseCase: GetUser(userRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PillProvider(
            addPillUseCase: AddPill(pillRepository),
            getPillsUseCase: GetPills(pillRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginWithGoogleUseCase: LoginWithGoogle(authRepository),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
