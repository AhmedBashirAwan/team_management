import 'package:flutter/material.dart';
import 'package:team_management/src/dashboard/components/admindashboard.dart';
import 'package:team_management/src/menu/notifications.dart';
import 'package:team_management/src/projects/components.dart/allprojects.dart';
import 'package:team_management/src/team/createteam.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedTab = 0;

  final List _pages = [
    const AdminDashboard(),
    const AllProjects(),
    const AddTeam(),
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
                icon: Icon(Icons.folder_copy_outlined), label: "Projects"),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_add_outlined), label: "Teams"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_important_outlined),
                label: "Notifications"),
          ],
        ),
      ),
    );
  }
}
