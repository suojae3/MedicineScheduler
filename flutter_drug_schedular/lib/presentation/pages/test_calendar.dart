import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_drug_schedular/presentation/providers/pill_provider.dart';
import 'package:flutter_drug_schedular/domain/entities/pill.dart';

class TestCalendar extends StatelessWidget {
  const TestCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeDateFormatting('ko_KR', null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: CalendarPage(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final pillProvider = Provider.of<PillProvider>(context);
    String formattedDate = DateFormat('M.dd E', 'ko_KR').format(_selectedDay ?? DateTime.now());

    List<Pill> pillsForSelectedDay = pillProvider.getPillsForDay(_selectedDay ?? DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('약 복용 스케쥴러', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: _buildCalendar(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Text(
              formattedDate,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _buildPillList(pillsForSelectedDay, formattedDate),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      daysOfWeekHeight: 32.0,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: const BoxDecoration(),
        selectedTextStyle: const TextStyle(color: Colors.white),
        selectedDecoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, _) => CustomDayWidget(date: date, isToday: true),
        selectedBuilder: (context, date, _) => CustomDayWidget(date: date, isSelected: true),
        defaultBuilder: (context, date, _) => CustomDayWidget(date: date, isFuture: date.isAfter(DateTime.now())),
        outsideBuilder: (context, date, _) => CustomDayWidget(date: date, isOutside: true, isFuture: date.isAfter(DateTime.now())),
      ),
    );
  }

  Widget _buildPillList(List<Pill> pills, String date) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: pills.isEmpty ? 1 : pills.length,
      itemBuilder: (context, index) {
        if (pills.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text('No pills scheduled for $date'),
              ),
            ),
          );
        } else {
          final pill = pills[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Container(
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                leading: Container(
                  width: 5.0,
                  color: pill.color,
                ),
                title: Text(pill.name),
                subtitle: Text(pill.description),
              ),
            ),
          );
        }
      },
    );
  }
}

class CustomDayWidget extends StatelessWidget {
  final DateTime date;
  final List<Color> colors1;
  final List<Color> colors2;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;
  final bool isFuture;

  const CustomDayWidget({
    required this.date,
    this.colors1 = const [Color(0xFFFFA726), Color(0xFF42A5F5), Color(0xFF66BB6A)],
    this.colors2 = const [Color(0xFFFF7043), Color(0xFF7E57C2)],
    this.isToday = false,
    this.isSelected = false,
    this.isOutside = false,
    this.isFuture = false,
  });

  Color getBackgroundColor() {
    if (isToday) return Colors.black;
    if (isSelected) return Colors.black.withOpacity(0.5);
    return Colors.transparent;
  }

  Color getTextColor() {
    if (isToday || isSelected) return Colors.white;
    if (isOutside) return Colors.grey;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${date.day}',
            style: TextStyle(fontSize: 13.0, color: getTextColor()),
          ),
        ),
        const SizedBox(height: 5),
        DoubleCircleRow(
          colors1: colors1,
          colors2: colors2,
          isTransparent: isFuture || isOutside,
        ),
      ],
    );
  }
}

class DoubleCircleRow extends StatelessWidget {
  final List<Color> colors1;
  final List<Color> colors2;
  final bool isTransparent;

  const DoubleCircleRow({
    required this.colors1,
    required this.colors2,
    required this.isTransparent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleRow(colors: colors1, isTransparent: isTransparent, maxCircles: 3),
        const SizedBox(height: 5),
        CircleRow(colors: colors2, isTransparent: isTransparent, maxCircles: 3),
      ],
    );
  }
}

class CircleRow extends StatelessWidget {
  final List<Color> colors;
  final bool isTransparent;
  final int maxCircles;

  const CircleRow({
    required this.colors,
    required this.isTransparent,
    required this.maxCircles,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    for (int i = 0; i < maxCircles; i++) {
      if (i < colors.length) {
        rowChildren.add(CircleWidget(color: colors[i], isTransparent: isTransparent));
      } else {
        rowChildren.add(SizedBox(width: 5.0));
      }
      if (i < maxCircles - 1) {
        rowChildren.add(const SizedBox(width: 5));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowChildren,
    );
  }
}

class CircleWidget extends StatelessWidget {
  final Color color;
  final bool isTransparent;

  const CircleWidget({
    required this.color,
    required this.isTransparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.0,
      height: 5.0,
      decoration: BoxDecoration(
        color: color.withOpacity(isTransparent ? 0.3 : 1.0),
        shape: BoxShape.circle,
      ),
    );
  }
}
