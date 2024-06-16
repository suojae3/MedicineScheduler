import 'package:flutter/material.dart';
import 'package:flutter_drug_schedular/global.dart';
import 'package:flutter_drug_schedular/presentation/pages/add_pill_screen.dart';
import 'package:flutter_drug_schedular/presentation/pages/login_screen.dart';
import 'package:flutter_drug_schedular/presentation/pages/profile_screen.dart';
import 'package:flutter_drug_schedular/presentation/pages/test_calendar.dart';
import 'package:flutter_drug_schedular/presentation/pages/meditime_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_drug_schedular/presentation/providers/pill_provider.dart';
import 'package:flutter_drug_schedular/presentation/providers/user_provider.dart'; // Import the UserProvider

void main() {
  Global.baseURL = "https://flutter_drug_schedular/dev/";
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PillProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()), // Add UserProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(), // 로그인 화면으로 시작
    );
  }
}
