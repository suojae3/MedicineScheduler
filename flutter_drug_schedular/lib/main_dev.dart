import 'package:flutter/material.dart';
import 'package:flutter_drug_schedular/global.dart';
import 'package:flutter_drug_schedular/presentation/pages/add_pill_screen.dart';
import 'package:flutter_drug_schedular/presentation/pages/test_calednar.dart';
import 'package:flutter_drug_schedular/presentation/pages/meditime_screen.dart';

void main() {
  Global.baseURL = "https://flutter_drug_schedular/dev/";
  runApp(testMyApp());
}

class testMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          MeditimeScreen(), // 첫 번째 탭의 내용
          TestCalendar(), // 두 번째 탭의 내용
          Center(child: Text('Settings')), // 세 번째 탭의 내용
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // 배경색을 흰색으로 설정
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
