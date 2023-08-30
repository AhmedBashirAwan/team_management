import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../customised/widgets/bottomnavigation.dart';
import '../auth/register/register.dart';

class OpenTasks extends StatefulWidget {
  const OpenTasks({super.key});

  @override
  State<OpenTasks> createState() => _OpenTasksState();
}

class _OpenTasksState extends State<OpenTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 10, top: 10, bottom: 6, left: 10),
            child: Container(
              width: getwidth(context) * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.0,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Landing Page Design',
                  style: TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
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
                      child: Row(
                        children: [
                          const Text('Work In Progress'),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                      color: Color(0xFF575757),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Text('Add Description'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: DottedBorder(
                dashPattern: [5, 5],
                color: const Color(0xFF75A143),
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
            const Row(
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
            const Padding(
              padding: EdgeInsets.only(top: 27),
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
                      backgroundColor:
                          const Color(0xFF92BB64), // Background color
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
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
