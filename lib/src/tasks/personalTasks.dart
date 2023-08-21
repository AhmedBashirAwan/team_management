import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalTasks extends StatefulWidget {
  const PersonalTasks({Key? key}) : super(key: key);

  @override
  State<PersonalTasks> createState() => _PersonalTasksState();
}

class _PersonalTasksState extends State<PersonalTasks> {
  List<String> assignedTask = [];
  Future<void> usersAssigns() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snap.docs.isNotEmpty) {
      assignedTask = snap.docs.map((doc) => doc['task_ID'] as String).toList();
    }
  }

  List<String> taskTitle = [];
  List<String> taskDescription = [];

  Future<void> gettingTasks() async {
    taskTitle.clear();
    taskDescription.clear();

    for (var element in assignedTask) {
      DocumentSnapshot<Map<String, dynamic>> taskSnap = await FirebaseFirestore
          .instance
          .collection('tasks')
          .doc(element)
          .get();

      taskTitle.add(taskSnap.get('title') as String);
      taskDescription.add(taskSnap.get('description') as String);
    }
  }

  @override
  void initState() {
    super.initState();
    usersAssigns().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const Text(
                'Your Assigned Tasks are :',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              FutureBuilder<void>(
                future: gettingTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: taskTitle.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                      child: Text(
                                        '$index',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        taskTitle[index],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        taskDescription[index],
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
