import 'package:flutter/material.dart';
import 'package:flutter_drug_schedular/domain/entities/pill.dart';

class PillProvider with ChangeNotifier {
  final List<Pill> _todayPills = [
    Pill(
      name: '루테인',
      time: DateTime(2024, 6, 12, 13, 0),  // 2024년 6월 12일 오후 1:00
      period: '오후 1:00',
      cycle: '오후 2:30',
      description: '셀렉스',
      color: Colors.blue,
      imagePath: 'assets/test-pills.png',
    ),
    Pill(
      name: '멀티비타민',
      time: DateTime(2024, 6, 13, 19, 0),  // 2024년 6월 12일 오후 7:00
      period: '오후 7:00',
      cycle: '',
      description: '센트롬 우먼',
      color: Colors.yellow,
      imagePath: 'assets/test-pills.png',
    ),
    Pill(
      name: 'SSRI',
      time: DateTime(2024, 6, 12, 19, 0),  // 2024년 6월 12일 오후 7:00
      period: '오후 7:00',
      cycle: '',
      description: '항우울제',
      color: Colors.grey,
      imagePath: 'assets/test-pills.png',
    ),
  ];

  final List<Pill> _allPills = [];

  PillProvider() {
    // Initialize _allPills with _todayPills for demonstration
    _allPills.addAll(_todayPills);
  }

  List<Pill> get todayPills => _todayPills;
  List<Pill> get allPills => _allPills;

  void addPill(Pill pill) {
    _allPills.add(pill);
    notifyListeners();
  }

  List<Pill> getPillsForDay(DateTime day) {
    return _allPills.where((pill) {
      return pill.time.year == day.year &&
          pill.time.month == day.month &&
          pill.time.day == day.day;
    }).toList()..sort((a, b) => a.time.compareTo(b.time));
  }
}
