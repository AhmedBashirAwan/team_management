import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/dashboard/components/drawer.dart';
import 'package:team_management/src/projects/screens/moduels.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  Future<String?> getUserData() async {
    final getData = await FirebaseFirestore.instance
        .collection('userData')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    dynamic data = getData.docs.first.data();
    print(data['fullName']);
    return data['fullName'];
  }

  List<String> projectIds = [];
  List<String> projectNames = [];
  Future<void> userProjects() async {
    try {
      QuerySnapshot moduleSnapshot = await FirebaseFirestore.instance
          .collection('projects')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (moduleSnapshot.docs.isNotEmpty) {
        setState(() {
          projectNames =
              moduleSnapshot.docs.map((doc) => doc['title'] as String).toList();
          projectIds = moduleSnapshot.docs.map((doc) => doc.id).toList();
        });
      } else {
        print("No projects found for user ");
      }
    } catch (error) {
      print("Error fetching projects: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(child: CustomDrawer()),
      body: FutureBuilder(
        builder: (context, snapshot) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
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
                          future: getUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userData = snapshot.data;
                              if (userData == null) {
                                return Text('No data available');
                              }
                              return Text(
                                userData,
                                style: TextStyle(fontSize: 20),
                              );
                            }
                          },
                        ),
                        Icon(
                          Icons.waving_hand_rounded,
                          color: Colors.orange.shade600,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.calendar_today_outlined),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
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
                                  print(
                                      "Selected Module ID: $selectedProjectId");

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
                                      style: TextStyle(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.73,
                      // child: ListView.builder(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   physics: const ClampingScrollPhysics(),
                      //   scrollDirection: Axis.vertical,
                      //   shrinkWrap: true,
                      //   // itemCount: userDataList.length,
                      //   itemBuilder: (context, index) {
                      //     return GestureDetector(
                      //       onTap: () {},
                      //       child: Container(
                      //         margin: const EdgeInsets.only(top: 10),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         height: MediaQuery.of(context).size.height * 0.13,
                      //         child: Material(
                      //           elevation: 5,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(15),
                      //           ),
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(left: 20),
                      //             child: Row(
                      //               children: [
                      //                 Container(
                      //                   height: 50,
                      //                   margin: const EdgeInsets.only(left: 5),
                      //                   child: ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(100),
                      //                     child: Image.network(
                      //                       'https://i2-prod.gazettelive.co.uk/incoming/article20679579.ece/ALTERNATES/s615b/0_jwr_mga_260521willowgracecampbell.jpg',
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 15,
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     Row(
                      //                       children: [
                      //                         // Text(
                      //                         //   userData['fullName'] ?? '',
                      //                         //   style: TextStyle(
                      //                         //     fontWeight: FontWeight.w500,
                      //                         //     fontSize: 16,
                      //                         //     color: Colors.black,
                      //                         //   ),
                      //                         // ),
                      //                       ],
                      //                     ),
                      //                     SizedBox(
                      //                       height: 3,
                      //                     ),
                      //                     // Text(
                      //                     //   userData['email'] ?? '',
                      //                     //   style: TextStyle(
                      //                     //     fontWeight: FontWeight.w500,
                      //                     //     fontSize: 13,
                      //                     //     color: Colors.black,
                      //                     //   ),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
