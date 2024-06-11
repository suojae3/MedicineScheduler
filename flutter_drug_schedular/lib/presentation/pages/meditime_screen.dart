import 'package:flutter/material.dart';
import 'package:flutter_drug_schedular/domain/entities/pill.dart';

class MeditimeScreen extends StatefulWidget {
  @override
  _MeditimeScreenState createState() => _MeditimeScreenState();
}

class _MeditimeScreenState extends State<MeditimeScreen> {
  bool showToday = true;

  final List<Pill> todayPills = [
    Pill(
        name: '루테인',
        time: DateTime.now().add(Duration(hours: 1)),
        period: '오후 1:00',
        cycle: '오후 2:30',
        description: '셀렉스',
        color: Colors.blue,
        imagePath: 'assets/test-pills.png'),
    Pill(
        name: '멀티비타민',
        time: DateTime.now().add(Duration(hours: 7)),
        period: '오후 7:00',
        cycle: '',
        description: '센트롬 우먼',
        color: Colors.yellow,
        imagePath: 'assets/test-pills.png'),
    Pill(
        name: 'SSRI',
        time: DateTime.now().add(Duration(hours: 7)),
        period: '오후 7:00',
        cycle: '',
        description: '항우울제',
        color: Colors.grey,
        imagePath: 'assets/test-pills.png'),
  ];

  final List<Pill> allPills = [
    // 모든 복용 약 목록을 추가하세요.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditime'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showToday = true;
                  });
                },
                child: Text(
                  '오늘(${todayPills.length})',
                  style: TextStyle(
                    color: showToday ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showToday = false;
                  });
                },
                child: Text(
                  '전체(${allPills.length})',
                  style: TextStyle(
                    color: showToday ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: showToday ? todayPills.length : allPills.length,
              itemBuilder: (context, index) {
                final pill = showToday ? todayPills[index] : allPills[index];
                return ListTile(
                  leading: Container(
                    width: 5.0,
                    height: double.infinity,
                    color: pill.color,
                  ),
                  title: Row(
                    children: [
                      Image.asset(
                        pill.imagePath ?? "",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pill.name),
                          Text(pill.period),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.check_circle_outline),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
