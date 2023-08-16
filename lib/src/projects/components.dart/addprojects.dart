import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/controllers/projectcontroller.dart';
import 'package:team_management/controllers/teamcontroller.dart';
import 'package:team_management/src/projects/screens/moduels.dart';
import '../../auth/register/register.dart';

class AddProject extends StatefulWidget {
  const AddProject({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final projectTitleController = TextEditingController();
  TextEditingController? selectedTeamController = TextEditingController();

  Future<String?> gettingTeamsId() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('teams')
          .where('name', isEqualTo: selectedTeamController!.text.trim())
          .get();

      if (snap.docs.isNotEmpty) {
        String teamID = snap.docs.first.id;
        return teamID;
      } else {
        return null; // Team not found
      }
    } catch (e) {
      print("Error getting team ID: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: getHeight(context) * 0.6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'New Project',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: getHeight(context) * 0.03,
                ),
                const Row(
                  children: [
                    Text(
                      'Task Title',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context) * 0.015,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            String? teamID = await gettingTeamsId();
                            String projectId =
                                await ProjectController().createProject(
                              projectTitleController.text.trim(),
                              teamID,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Moduels(
                                  projectId: projectId,
                                ),
                              ),
                            );
                            print(projectId);
                          },
                          controller: projectTitleController,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.blue,
                          decoration: const InputDecoration(
                            hintText: 'Name your Project.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Team',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Material(
                                    child: FutureBuilder<
                                        List<Map<String, dynamic>>>(
                                      future: TeamController().getTeamsData(),
                                      builder: (context, snapshot) {
                                        List<Map<String, dynamic>>
                                            filteredData = [];
                                        if (snapshot.hasData) {
                                          try {
                                            var teamData = snapshot.data;
                                            if (teamData != null) {
                                              for (var team in teamData) {
                                                var uid = FirebaseAuth
                                                    .instance.currentUser!.uid;
                                                for (var mem
                                                    in team['members']) {
                                                  mem;
                                                  if (mem.toString() ==
                                                      uid.toString()) {
                                                    print("true");
                                                    filteredData.add(team);

                                                    break;
                                                  }
                                                }
                                              }
                                            }
                                          } catch (e) {
                                            e;
                                            print(e);
                                          }
                                          return ListView.builder(
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: filteredData.length,
                                            itemBuilder: (context, index) {
                                              final teamName =
                                                  filteredData[index]['name']
                                                      .toString();
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 5),
                                                child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      selectedTeamController
                                                          ?.text = teamName;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      height:
                                                          getHeight(context) *
                                                              0.06,
                                                      child: Center(
                                                          child:
                                                              Text(teamName))),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                });
                          },
                          readOnly: true,
                          controller: selectedTeamController,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.blue,
                          decoration: const InputDecoration(
                            hintText: 'Team Name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                      width: getwidth(context) * 0.4,
                      height: getHeight(context) * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Create',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          String? teamID = await gettingTeamsId();
                          String projectId =
                              await ProjectController().createProject(
                            projectTitleController.text.trim(),
                            teamID,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Moduels(
                                projectId: projectId,
                              ),
                            ),
                          );
                        },
                      )),
                ),
                SizedBox(
                  height: getHeight(context) * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
