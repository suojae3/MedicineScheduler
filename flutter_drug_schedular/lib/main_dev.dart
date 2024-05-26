
import 'package:flutter/material.dart';
import 'package:flutter_drug_schedular/global.dart';
import 'package:flutter_drug_schedular/main.dart';
import 'package:flutter_drug_schedular/presentation/pages/test_calednar.dart';


void main() {
  Global.baseURL = "https://flutter_drug_schedular/dev/";
  // runApp(const MyApp());
  runApp(TestCalendar());
}

