import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/dashboard/screen/dashboard.dart';
import 'package:team_management/src/tasks/tasks.dart';

import '../../../customised/widgets/bottomnavigation.dart';

// ignore: must_be_immutable
class Moduels extends StatefulWidget {
  Moduels({super.key, required this.projectId});
  String projectId;
  @override
  State<Moduels> createState() => _ModuelsState();
}

class _ModuelsState extends State<Moduels> {
  TextEditingController moduelTitleController = TextEditingController();
  String projectName = '';
  Future<String?> addModuels(String moduelTitle) async {
    Map<String, dynamic> payload = {
      'title': moduelTitle,
    };
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('moduels')
        .add(payload);
    return null;
  }

  List<String> moduleIds = [];
  List<String> moduleNames = [];
  void fetchProjectName() async {
    DocumentSnapshot projectSnapshot = await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .get();

    if (projectSnapshot.exists) {
      setState(() {
        projectName = projectSnapshot['title'];
      });
    }
  }

  Future<void> projectModules() async {
    try {
      QuerySnapshot moduleSnapshot = await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('moduels')
          .get();

      if (moduleSnapshot.docs.isNotEmpty) {
        setState(() {
          moduleNames =
              moduleSnapshot.docs.map((doc) => doc['title'] as String).toList();
          moduleIds = moduleSnapshot.docs.map((doc) => doc.id).toList();
        });
      } else {}
    } catch (error) {
      error;
    }
  }

  Future<void> addModuleAndRefresh(String moduleTitle) async {
    await addModuels(moduleTitle);
    await projectModules();
  }

  @override
  void initState() {
    super.initState();
    fetchProjectName();
    projectModules();
  }

  @override
  void dispose() {
    moduelTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context) * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Text(projectName,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Moduels:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemCount: moduleNames.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              String selectedModuleId = moduleIds[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Tasks(
                                    projectID: widget.projectId,
                                    modueld: selectedModuleId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: getHeight(context) * 0.22,
                              width: getwidth(context) * 0.6,
                              child: Center(
                                child: Text(
                                  moduleNames[
                                      index], // Display the module name here
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        "Create new Moduels:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  height: getHeight(context) * 0.45,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Add a Module',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.03,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Text(
                              'Module Title',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.015,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextField(
                                  onSubmitted: (value) async {
                                    await addModuleAndRefresh(
                                        moduelTitleController.text.trim());
                                    moduelTitleController.clear();
                                  },
                                  controller: moduelTitleController,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: Colors.blue,
                                  decoration: const InputDecoration(
                                    hintText: 'e.g, Location Tracking',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                            width: getwidth(context) * 0.4,
                            height: getHeight(context) * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                'Add Up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                await addModuleAndRefresh(
                                    moduelTitleController.text.trim());
                                moduelTitleController.clear();
                              },
                            )),
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.04,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
