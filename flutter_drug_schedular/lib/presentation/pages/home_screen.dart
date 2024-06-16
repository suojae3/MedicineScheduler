import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_drug_schedular/presentation/pages/meditime_screen.dart';
import 'package:flutter_drug_schedular/presentation/pages/test_calendar.dart';
import 'package:flutter_drug_schedular/presentation/pages/profile_screen.dart';
import 'package:flutter_drug_schedular/presentation/providers/pill_provider.dart';
import 'package:flutter_drug_schedular/presentation/providers/user_provider.dart'; // Import UserProvider

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
        physics: NeverScrollableScrollPhysics(), // 스와이핑 비활성화
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          MeditimeScreen(), // 첫 번째 탭의 내용
          TestCalendar(), // 두 번째 탭의 내용
          ProfileScreen(), // 세 번째 탭의 내용
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // 배경색을 흰색으로 설정
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4D8FF5), // 선택된 아이템 색상
        unselectedItemColor: Colors.black, // 선택되지 않은 아이템 색상
        selectedLabelStyle: TextStyle(fontSize: 0), // 라벨 크기 최소화
        unselectedLabelStyle: TextStyle(fontSize: 0), // 라벨 크기 최소화
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);  // 애니메이션 없이 페이지 변경
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/pencil.png')), // pencil.png 이미지 추가
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/calendar.png')), // calendar.png 이미지 추가
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/setting.png')), // setting.png 이미지 추가
            label: '',
          ),
        ],
      ),
    );
  }
}
