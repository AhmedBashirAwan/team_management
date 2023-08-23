import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';

class AdProject extends StatefulWidget {
  const AdProject({super.key});

  @override
  State<AdProject> createState() => _AdProjectState();
}

class _AdProjectState extends State<AdProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: const Icon(Icons.arrow_back),
        title: const Text('Create new Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Project Name',
                  style: TextStyle(
                      color: Color(0xFF575757),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.04,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter your Project Name',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: const Row(
                children: [
                  Text(
                    'Project Key',
                    style: TextStyle(
                        color: Color(0xFF575757),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.04,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter your Project Name',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.04,
            ),
            Container(
              width: getwidth(context),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF92BB64),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Create Project')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
