import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/controllers/teamcontroller.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/dashboard/components/drawer.dart';
import 'package:team_management/src/projects/screens/moduels.dart';
import '../../../controllers/usercontroller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<String> projectIds = [];
  List<String> projectNames = [];
  Future<void> userProjects() async {
    QuerySnapshot moduleSnapshot =
        await FirebaseFirestore.instance.collection('projects').get();

    if (moduleSnapshot.docs.isNotEmpty) {
      projectNames =
          moduleSnapshot.docs.map((doc) => doc['title'] as String).toList();
      projectIds = moduleSnapshot.docs.map((doc) => doc.id).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(child: CustomDrawer()),
      body: FutureBuilder(
        future: userProjects(),
        builder: (context, snapshot) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FutureBuilder<String?>(
                          future: UserController().getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userData = snapshot.data;
                              if (userData == null) {
                                return const Text('No data available');
                              }
                              return Text(
                                userData,
                                style: const TextStyle(fontSize: 20),
                              );
                            }
                          },
                        ),
                        Icon(
                          Icons.waving_hand_rounded,
                          color: Colors.orange.shade600,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.calendar_today_outlined),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: projectNames.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                onTap: () {
                                  String selectedProjectId = projectIds[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Moduels(
                                        projectId: selectedProjectId,
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
                                      projectNames[index],
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            "Your Team Members are :",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: TeamController().getTeamsData(),
                      builder: (context, snapshot) {
                        List<Map<String, dynamic>> filteredData = [];
                        if (snapshot.hasData) {
                          try {
                            var teamData = snapshot.data;
                            if (teamData != null) {
                              for (var team in teamData) {
                                var uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                for (var mem in team['members']) {
                                  if (mem.toString() == uid.toString()) {
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: filteredData.length,
                            itemBuilder: (context, index) {
                              final teamName =
                                  filteredData[index]['name'].toString();
                              return Container(
                                height: getHeight(context) * 0.07,
                                // color: Colors.grey.shade800,
                                child: Center(
                                    child: Text(
                                  teamName,
                                  style: TextStyle(fontSize: 20),
                                )),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
