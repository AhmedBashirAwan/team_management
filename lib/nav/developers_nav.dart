import 'package:flutter/material.dart';
import 'package:team_management/src/Dashboard/screen/dashboard.dart';
import 'package:team_management/src/menu/notifications.dart';
import 'package:team_management/src/tasks/addnewtask.dart';

import '../src/calendar.dart';

class DevelopersNav extends StatefulWidget {
  const DevelopersNav({super.key});

  @override
  State<DevelopersNav> createState() => _DevelopersNavState();
}

class _DevelopersNavState extends State<DevelopersNav> {
  int _selectedTab = 0;

  final List _pages = [
    const Dashboard(),
    const AddNewTask(),
    const Calendar(),
    const Notifications()
  ];
  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: Colors.black),
        child: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: const Color(0xFF75A143),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), label: "Add Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: "Calendar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined), label: "Messages"),
          ],
        ),
      ),
    );
  }
}
