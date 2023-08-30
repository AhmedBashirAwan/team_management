// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/tasks/createtask.dart';

class AllTasks extends StatefulWidget {
  AllTasks({super.key, required this.mod_ID, required this.pro_ID});
  String pro_ID;
  String mod_ID;

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  List<String> taskTitle = [];
  List<String> taskIds = [];

  Future<void> fetchingTasks() async {
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('tasks')
        .where('mod_ID', isEqualTo: widget.mod_ID)
        .get();

    taskTitle = snap.docs.map((doc) => doc['title'] as String).toList();
    taskIds = snap.docs.map((doc) => doc.id).toList();
  }

  @override
  void initState() {
    fetchingTasks();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text('All Tasks'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: fetchingTasks(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: taskIds.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 15, left: 20),
                        child: Material(
                          elevation: 30,
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: getHeight(context) * 0.09,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 2, color: Colors.black12)),
                                    height: 40,
                                    width: 40,
                                    child: const Center(
                                      child: Text('50%'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getwidth(context) * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              taskTitle[index],
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Due date',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFFA4A4A4)),
                                            ),
                                            Text(
                                              'Work In Progress',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF75A143)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Color(0xFF75A143),
            )),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateProject(
                mod_ID: widget.mod_ID,
                pro_ID: widget.pro_ID,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color(0xFF75A143),
        ),
      ),
    );
  }
}
