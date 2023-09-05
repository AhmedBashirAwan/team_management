// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/moduels/src/create_modules.dart';
import 'package:team_management/src/projects/components.dart/projectDetails.dart';
import 'package:team_management/src/tasks/alltasks.dart';
import 'package:team_management/src/tasks/task_details.dart';

class DisplayModules extends StatefulWidget {
  DisplayModules({super.key, required this.pro_ID});
  String pro_ID;

  @override
  State<DisplayModules> createState() => _DisplayModulesState();
}

class _DisplayModulesState extends State<DisplayModules> {
  String projectName = '';
  List<String> moduleNames = [];
  List<String> moduleDescription = [];
  List<String> moduleIds = [];

  List<List<String>> taskList = [];

  Future<void> fetchingAllModules() async {
    QuerySnapshot<Map<String, dynamic>> moduleSnapshot = await FirebaseFirestore
        .instance
        .collection('modules')
        .where('project_ID', isEqualTo: widget.pro_ID)
        .get();
    if (moduleSnapshot.docs.isNotEmpty) {
      moduleNames =
          moduleSnapshot.docs.map((doc) => doc['title'] as String).toList();
      moduleDescription = moduleSnapshot.docs
          .map((doc) => doc['description'] as String)
          .toList();
      moduleIds = moduleSnapshot.docs.map((doc) => doc.id).toList();
    }

    taskList = [];
    for (var element in moduleIds) {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('tasks')
          .where('mod_ID', isEqualTo: element)
          .get();
      List<String> moduleIdsForProject =
          snap.docs.map((doc) => doc.id).toList();
      taskList.add(moduleIdsForProject);
    }
  }

  Future<void> taskName() async {
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('projects')
        .doc(widget.pro_ID)
        .get();

    Map<String, dynamic>? data = snap.data();
    projectName = data!['title'];
  }

  @override
  void initState() {
    taskName();
    fetchingAllModules();
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
          future: taskName(),
          builder: (context, snapshot) {
            return Text(projectName);
          },
        ),
        actions: [
          InkWell(
            onTap: () {
                Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProjectDetails(
                                pro_ID: widget.pro_ID,
                              ),
                            ),
                          );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: getwidth(context) * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: const Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FutureBuilder(
            future: fetchingAllModules(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Modules',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Divider(),
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: moduleNames.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AllTasks(
                                pro_ID: widget.pro_ID,
                                mod_ID: moduleIds[index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, bottom: 15, left: 10),
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: getHeight(context) * 0.14,
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
                                                moduleNames[index],
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
                                              Column(
                                                children: [
                                                  Text(
                                                    moduleDescription[index],
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Color(0xFFA4A4A4)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text('1/${taskList.length}')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
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
              builder: (context) => CreateModules(
                pro_Id: widget.pro_ID,
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
