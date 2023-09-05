// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/globals.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/tasks/createtask.dart';
import 'package:team_management/src/tasks/task_details.dart';

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
  List<String> taskStatus = [];
  Future<void> fetchingTasks() async {
    if (role == 'Manager') {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('tasks')
          .where('mod_ID', isEqualTo: widget.mod_ID)
          .get();

      taskTitle = snap.docs.map((doc) => doc['title'] as String).toList();
      taskIds = snap.docs.map((doc) => doc.id).toList();
    } else {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('assignments')
          .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      taskIds = snap.docs.map((doc) => doc['task_ID'] as String).toList();

      // Clear the taskTitle list before populating it.
      taskTitle = [];

      for (var element in taskIds) {
        DocumentSnapshot<Map<String, dynamic>> geo = await FirebaseFirestore
            .instance
            .collection('tasks')
            .doc(element)
            .get();
        Map<String, dynamic>? titleData = geo.data();

        // Check if titleData contains 'title' key and append it to the list.
        if (titleData!['mod_ID'] == widget.mod_ID &&
            titleData.containsKey('title')) {
          taskTitle.add(titleData['title'] as String);
        }
      }
    }
  }

  Future<void> checkStatus() async {
    print(taskIds);
    taskStatus = [];
    for (var element in taskIds) {
      QuerySnapshot<Map<String, dynamic>> snapi = await FirebaseFirestore
          .instance
          .collection('assignments')
          .where('task_ID', isEqualTo: element)
          .get();
      // Map<String, dynamic> data = snapi.docs.first.data();
      taskStatus = snapi.docs.map((doc) => doc['status'].toString()).toList();
      // taskStatus.add(data['status'].toString());
    }
    print(taskStatus);
  }

  @override
  void initState() {
    // fetchingTasks();
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
        title: FutureBuilder(
          // future: checkStatus(),
          builder: (context, snapshot) {
            return Text('All Tasks');
          },
        ),
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
                    itemCount: taskTitle.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => TaskDetails(
                                      task_ID: taskIds[index],
                                    )),
                          );
                        },
                        child: Padding(
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                              FutureBuilder(
                                                future: checkStatus(),
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    // taskStatus[index] == 'false'
                                                    //     ? 'Work in Progress'
                                                    'Done',
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFF75A143)),
                                                  );
                                                },
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
