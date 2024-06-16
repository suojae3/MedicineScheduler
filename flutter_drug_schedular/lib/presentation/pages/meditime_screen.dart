import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_drug_schedular/domain/entities/pill.dart';
import 'add_pill_screen.dart';
import 'package:flutter_drug_schedular/presentation/providers/pill_provider.dart';

class MeditimeScreen extends StatefulWidget {
  @override
  _MeditimeScreenState createState() => _MeditimeScreenState();
}

class _MeditimeScreenState extends State<MeditimeScreen> {
  bool showToday = true;

  @override
  Widget build(BuildContext context) {
    final pillProvider = Provider.of<PillProvider>(context);
    final pills = showToday ? pillProvider.todayPills : pillProvider.allPills;

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
                  '오늘(${pillProvider.todayPills.length})',
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
                  '전체(${pillProvider.allPills.length})',
                  style: TextStyle(
                    color: showToday ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pills.length,
              itemBuilder: (context, index) {
                final pill = pills[index];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPillScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFF4D8FF5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5.0, // 그림자 추가
      ),
    );
  }
}
