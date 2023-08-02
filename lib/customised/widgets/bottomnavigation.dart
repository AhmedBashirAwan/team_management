import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/addprojects.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/chating/components/teamlist.dart';
import 'package:team_management/src/tasks/tasks.dart';
import 'package:team_management/src/team/screen/team.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) * 0.08,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamList(),
                  ),
                );
              },
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 35,
              icon: Icon(
                Icons.message_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTeam(),
                  ),
                );
              },
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 35,
              icon: Icon(Icons.person_2),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue, //<-- SEE HERE
              child: IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => showBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (context) => AddProject()),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tasks(),
                  ),
                );
              },
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 35,
              icon: Icon(
                Icons.task_sharp,
              ),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 30,
              icon: Icon(Icons.check_circle),
            )
          ],
        ),
      ),
    );
  }
}