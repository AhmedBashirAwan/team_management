// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/moduels/src/create_modules.dart';
import 'package:team_management/src/tasks/alltasks.dart';

class DisplayModules extends StatefulWidget {
  DisplayModules({super.key, required this.pro_ID});
  String pro_ID;

  @override
  State<DisplayModules> createState() => _DisplayModulesState();
}

class _DisplayModulesState extends State<DisplayModules> {
  List<String> moduleNames = [];
  List<String> moduleDescription = [];
  List<String> moduleIds = [];
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
  }

  @override
  void initState() {
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
        title: const Text('Modules'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FutureBuilder(
            future: fetchingAllModules(),
            builder: (context, snapshot) {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: moduleNames.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      String mod_ID = moduleIds[index];
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AllTasks(
                            mod_ID: mod_ID,
                            pro_ID: widget.pro_ID,
                          ),
                        ),
                      );
                      print(mod_ID);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: getHeight(context) * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade300),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(Icons.minimize_rounded))
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      moduleNames[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      moduleDescription[index],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
