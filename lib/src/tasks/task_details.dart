// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({
    super.key,
    required this.task_ID,
  });
  String task_ID;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String projectName = '';
  String modName = '';
  String taskName = '';
  String taskDescription = '';
  String assignTo = '';
  String dueDate = '';
  String priority = '';
  String status = '';
  String from = '';
  Future<void> fetchingDetails() async {
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('tasks')
        .doc(widget.task_ID)
        .get();

    Map<String, dynamic>? data = snap.data();
    taskName = data!['title'];

    taskDescription = data['description'];

    DocumentSnapshot<Map<String, dynamic>> projectSnap = await FirebaseFirestore
        .instance
        .collection('projects')
        .doc(data['pro_ID'])
        .get();
    Map<String, dynamic>? proData = projectSnap.data();
    projectName = proData!['title'];

    DocumentSnapshot<Map<String, dynamic>> modSnap = await FirebaseFirestore
        .instance
        .collection('modules')
        .doc(data['mod_ID'])
        .get();
    Map<String, dynamic>? modData = modSnap.data();
    modName = modData!['title'];
  }

  Future<void> fetchingAssignmentDetails() async {
    QuerySnapshot<Map<String, dynamic>> snapo = await FirebaseFirestore.instance
        .collection('assignments')
        .where('task_ID', isEqualTo: widget.task_ID)
        .get();

    QueryDocumentSnapshot<Map<String, dynamic>> data = snapo.docs.first;

    dueDate = data['dueDate'];
    priority = data['priority'];

    status = data['status'].toString();

    QuerySnapshot<Map<String, dynamic>> assigni = await FirebaseFirestore
        .instance
        .collection('userData')
        .where('userId', isEqualTo: data['assign_to'])
        .get();
    if (assigni.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> assigniData =
          assigni.docs.first;
      assignTo = assigniData['fullName'];
    } else {
      assignTo = 'Not Found';
    }

    QuerySnapshot<Map<String, dynamic>> assignfrom = await FirebaseFirestore
        .instance
        .collection('userData')
        .where('userId', isEqualTo: data['from'])
        .get();

    if (assignfrom.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> fromData =
          assignfrom.docs.first;
      from = fromData['fullName'];
    } else {
      from = 'Not Found';
    }
  }

  @override
  void initState() {
    fetchingDetails();
    fetchingAssignmentDetails();
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
        title: Row(
          children: [
            Text(taskName),
            const Spacer(),
            Container(
                height: getHeight(context) * 0.05,
                width: getwidth(context) * 0.25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  status == 'true' ? 'Done' : 'Working',
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ))),
          ],
        ),
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: fetchingDetails(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  height: getHeight(context) * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFFEEEDF)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Project',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: getHeight(context)*0.01,
                          ),
                          Text(
                            projectName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Module',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: getHeight(context)*0.01,
                          ),
                          Text(
                            modName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Priority : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Container(
                          height: getHeight(context) * 0.05,
                          width: getwidth(context) * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF92BB64)),
                          child: Center(
                              child: Text(
                            priority,
                            style: const TextStyle(color: Colors.white),
                          ))),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Assign To :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: getHeight(context) * 0.06,
                    width: getwidth(context),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEBFFD7),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(assignTo),
                        ],
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Assign From :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: getHeight(context) * 0.06,
                    width: getwidth(context),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEBFFD7),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(from),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
      )),
    );
  }
}
