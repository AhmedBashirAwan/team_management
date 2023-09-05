import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final List<String> nextDays = [];
  List<String> getnextDays() {
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime nextDate = currentDate.add(Duration(days: i));
      String formattedDate =
          "${nextDate.year}-${nextDate.month.toString().padLeft(2, '0')}-${nextDate.day.toString().padLeft(2, '0')}";
      nextDays.add(formattedDate);
    }

    return nextDays;
  }

  List<String> taskss = [];
  Future<void> assignmentsWeek() async {
    for (var element in nextDays) {
      try {
        QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
            .instance
            .collection('assignments')
            .where('assign_to',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('dueDate', isEqualTo: element)
            .get();

        taskss = snap.docs.map((doc) => doc['task_ID'] as String).toList();
      } catch (error) {
        print('Error fetching assignments: $error');
      }
    }
    taskss;
  }

  @override
  void initState() {
    getnextDays();
    assignmentsWeek();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: const Text('Calendar'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Timeline',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: nextDays.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: getHeight(context) * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            nextDays[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                          Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      height: 1,
                                      width: getwidth(context) * 0.65,
                                      decoration:
                                          BoxDecoration(color: Colors.black45),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Container(
                                      height: getHeight(context) * 0.04,
                                      width: getwidth(context) * 0.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xFFFEEEDF)),
                                      child: Center(
                                          child: Text('Landing Page Design')),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
