import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: const Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  foregroundColor: Colors.black, // Text color
                  elevation: 5, // Elevation (shadow)
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Border radius
                  ),
                ),
                onPressed: () {},
                child: const Text('Create')),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Text(
                    'Project',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.05,
              child: TextField(
                decoration: InputDecoration(
                    suffixIconColor: Color(0xFFA8A8A8),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                    hintText: 'Enter your Project Name',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  'Add Description',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF575757)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: DottedBorder(
                dashPattern: [5, 5],
                color: Color(0xFF75A143),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: getHeight(context) * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        color: Color(0xFF979797),
                      ),
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Drop files to attach or ',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF979797))),
                        TextSpan(
                            text: 'Browse',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF75A143)))
                      ]))
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    'Assignee',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: getHeight(context) * 0.035,
                child: TextField(
                  decoration: InputDecoration(
                      suffixIconColor: Color(0xFFA8A8A8),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                      hintText: 'UnAssigned',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Periority',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF575757)),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.035,
              child: TextField(
                decoration: InputDecoration(
                    suffixIconColor: Color(0xFFA8A8A8),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                    hintText: 'Medium',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Row(
                children: [
                  Text(
                    'TimeLine',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF92BB64), // Background color
                      foregroundColor: Colors.white, // Text color
                      elevation: 5, // Elevation (shadow)
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Border radius
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Aug 18-19')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF92BB64), // Background color
                        foregroundColor: Colors.white, // Text color
                        elevation: 5, // Elevation (shadow)
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Border radius
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Set Time')),
                ),
              ],
            )
          ],
        ),
      )),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
