import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TestCalendar extends StatelessWidget {
  const TestCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarPage(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('약 복용 스케쥴러'),
      ),
      body: TableCalendar(
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
        daysOfWeekHeight: 32.0, // 요일과 날짜 사이의 간격을 조정합니다.
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          todayDecoration: const BoxDecoration(), // 기본값은 빈 BoxDecoration
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
          todayBuilder: (context, date, _) => CustomDayWidget(
            date: date,
            colors1: const [
              Color(0xFFFFA726),
              Color(0xFF42A5F5),
              Color(0xFF66BB6A),
            ],
            colors2: const [
              Color(0xFFFF7043),
              Color(0xFF7E57C2),
              // Color(0xFF26C6DA),
            ],
            isToday: true,
          ),
          selectedBuilder: (context, date, _) => CustomDayWidget(
            date: date,
            colors1: const [
              Color(0xFFFFA726),
              Color(0xFF42A5F5),
              Color(0xFF66BB6A),
            ],
            colors2: const [
              Color(0xFFFF7043),
              // Color(0xFF7E57C2),
              // Color(0xFF26C6DA),
            ],
            isSelected: true,
          ),
          defaultBuilder: (context, date, _) => CustomDayWidget(
            date: date,
            colors1: const [
              Color(0xFFFFA726),
              Color(0xFF42A5F5),
              Color(0xFF66BB6A),
            ],
            colors2: const [
              Color(0xFFFF7043),
              // Color(0xFF7E57C2),
              // Color(0xFF26C6DA),
            ],
            isFuture: date.isAfter(DateTime.now()),
          ),
          outsideBuilder: (context, date, _) => CustomDayWidget(
            date: date,
            colors1: const [
              Color(0xFFFFA726),
              Color(0xFF42A5F5),
              Color(0xFF66BB6A),
            ],
            colors2: const [
              Color(0xFFFF7043),
              // Color(0xFF7E57C2),
              // Color(0xFF26C6DA),
            ],
            isOutside: true,
            isFuture: date.isAfter(DateTime.now()),
          ),
        ),
      ),
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
    required this.colors1,
    required this.colors2,
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
            style: TextStyle(
              fontSize: 13.0,
              color: getTextColor(),
            ),
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
        const SizedBox(height: 5), // 줄 사이에 간격을 추가
        CircleRow(colors: colors2, isTransparent: isTransparent, maxCircles: 3),
      ],
    );
  }
}

class CircleRow extends StatelessWidget {
  final List<Color> colors;
  final bool isTransparent;
  final int maxCircles;

  const CircleRow({required this.colors, required this.isTransparent, required this.maxCircles});

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    for (int i = 0; i < maxCircles; i++) {
      if (i < colors.length) {
        rowChildren.add(CircleWidget(color: colors[i], isTransparent: isTransparent));
      } else {
        rowChildren.add(SizedBox(width: 5.0)); // 빈 자리 채우기
      }
      if (i < maxCircles - 1) {
        rowChildren.add(const SizedBox(width: 5)); // 동그라미 사이에 간격을 추가
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

  const CircleWidget({required this.color, required this.isTransparent});

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
