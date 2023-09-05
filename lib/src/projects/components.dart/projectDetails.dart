import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';

class ProjectDetails extends StatefulWidget {
  ProjectDetails({super.key, required this.pro_ID});
  String pro_ID;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  String teamName = '';
  String created_by = '';
  String projectName = '';
  Future<void> taskName() async {
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('projects')
        .doc(widget.pro_ID)
        .get();

    Map<String, dynamic>? data = snap.data();
    projectName = data!['title'];
  }

  Future<void> fetchingDetails() async {
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('projects')
        .doc(widget.pro_ID)
        .get();
    Map<String, dynamic>? data = snap.data();

    QuerySnapshot<Map<String, dynamic>> createrSnap = await FirebaseFirestore
        .instance
        .collection('userData')
        .where('userId', isEqualTo: data!['created_by'])
        .get();
    Map<String, dynamic> creater = createrSnap.docs.first.data();
    created_by = creater['fullName'];

    DocumentSnapshot<Map<String, dynamic>> teamSnap = await FirebaseFirestore
        .instance
        .collection('teams')
        .doc(data['team_ID'])
        .get();
    Map<String, dynamic>? teams = teamSnap.data();

    teamName = teams!['name'];
  }

  List<String> moduleCount = [];
  Future<void> numbersOfMods() async {
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('modules')
        .where('project_ID', isEqualTo: widget.pro_ID)
        .get();
    moduleCount = snap.docs.map((doc) => doc.id.toString()).toList();
  }

  @override
  void initState() {
    numbersOfMods();
    fetchingDetails();
    taskName();
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
        title: Row(
          children: [
            FutureBuilder(
              future: taskName(),
              builder: (context, snapshot) {
                return Text(projectName);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      body: FutureBuilder(
        future: fetchingDetails(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0,
            horizontal: 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Project Manager :',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                          Text(created_by),
                        ],
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Team Name :',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                          Text(teamName),
                        ],
                      ),
                    )),
                Row(
                  children: [
                    FutureBuilder(
                      future: numbersOfMods(),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              const Text(
                                'Modules in this Project ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: getwidth(context)*0.03,
                              ),
                              Container(
                                height: getHeight(context)*0.05,
                                width: getwidth(context)*0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFEBFFD7),
                                ),
                                child: Center(child: Text('1 / ${moduleCount.length}'))),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
