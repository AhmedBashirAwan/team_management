import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/dashboard/components/admindashboard.dart';
import 'package:team_management/src/menu/notifications.dart';
import 'package:team_management/src/projects/components.dart/allprojects.dart';
import 'package:team_management/src/team/createteam.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF272525),
      height: getHeight(context) * 0.08,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminDashboard(),
                  ),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AllProjects(),
                  ),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_copy_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Projects',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTeam(),
                  ),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Add Task',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Notifications(),
                  ),
                );
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Notification',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
