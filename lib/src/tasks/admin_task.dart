import 'package:flutter/material.dart';
import '../../customised/widgets/bottomnavigation.dart';

class AdminTasks extends StatefulWidget {
  const AdminTasks({super.key});

  @override
  State<AdminTasks> createState() => _AdminTasksState();
}

class _AdminTasksState extends State<AdminTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('All Open Tasks '),
            Text(
              '(IPOS)',
              style: TextStyle(fontSize: 12),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Landing Page Design',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    'Work In progress',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF75A143)),
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Color(0xFF75A143),
            )),
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Color(0xFF75A143),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
