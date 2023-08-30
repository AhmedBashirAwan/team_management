import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/controllers/projectcontroller.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/projects/components.dart/allprojects.dart';

class AdProject extends StatefulWidget {
  const AdProject({super.key});

  @override
  State<AdProject> createState() => _AdProjectState();
}

class _AdProjectState extends State<AdProject> {
  TextEditingController _projectName = TextEditingController();
  TextEditingController _teamName = TextEditingController();
  String selectedID = '';

  List<String> teamName = [];
  List<String> teamID = [];
  Future<void> fetchingAllTheTeams() async {
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('teams').get();

    teamName = snap.docs.map((doc) => doc['name'] as String).toList();
    teamID = snap.docs.map((doc) => doc.id).toList();
  }

  @override
  void initState() {
    fetchingAllTheTeams();
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
        title: const Text('Create new Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Project Name',
                  style: TextStyle(
                      color: Color(0xFF575757),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.04,
              child: TextField(
                controller: _projectName,
                decoration: const InputDecoration(
                    hintText: 'Enter your Project Name',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Text(
                    'Project Team',
                    style: TextStyle(
                        color: Color(0xFF575757),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.04,
              child: TextField(
                onTap: () {
                  _showBottomSheet(context);
                },
                readOnly: true,
                controller: _teamName,
                decoration: const InputDecoration(
                    hintText: 'Enter your Project Name',
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.04,
            ),
            SizedBox(
              width: getwidth(context),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF92BB64),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    ProjectController()
                        .createProject(_projectName.text.trim(), selectedID);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AllProjects(),
                      ),
                    );
                  },
                  child: const Text('Create Project')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

  void _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: getHeight(context) * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: getHeight(context) * 0.04,
                  child: TextField(
                    controller: _teamName,
                    decoration: const InputDecoration(
                      hintText: '  Select a Team',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: teamName.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _teamName.text = teamName[index];
                          selectedID = teamID[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  teamName[index],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF3A3A3A),
                                  ),
                                ),
                                const Text(
                                  'Software Team',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF575757),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
