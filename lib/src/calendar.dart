import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team_management/src/auth/register/register.dart';

class Event {
  final String title;

  Event(this.title);
}

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> events = {
    DateTime.now(): [Event('Sample Event')],
    DateTime.now().add(const Duration(days: 1)): [Event('Another Event')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: const Icon(Icons.arrow_back),
        title: const Text('Calendar'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 10,
              child: Container(
                height: getHeight(context) * 0.36,
                color: const Color(0xFFEBFFD7),
                child: TableCalendar(
                  weekendDays: const [DateTime.saturday, DateTime.sunday],
                  rowHeight: getHeight(context) * 0.05,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    return _getEventsForDay(day);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
