import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/moduels/components/all_modules.dart';
import '../../projects/components.dart/adproject.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<String> projectIds = [];
  List<String> projectNames = [];
  List<List<String>> modIDsList = [];
  Future<void> userProjects() async {
    QuerySnapshot moduleSnapshot =
        await FirebaseFirestore.instance.collection('projects').get();

    if (moduleSnapshot.docs.isNotEmpty) {
      projectNames =
          moduleSnapshot.docs.map((doc) => doc['title'] as String).toList();
      projectIds = moduleSnapshot.docs.map((doc) => doc.id).toList();
    }

    for (var element in projectIds) {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('modules')
          .where('project_ID', isEqualTo: element)
          .get();
      List<String> moduleIdsForProject =
          snap.docs.map((doc) => doc.id).toList();
      modIDsList.add(moduleIdsForProject);
    }
  }

  List<String> taskTitle = [];
  List<String> taskIds = [];

  Future<void> fetchingTasks() async {
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('tasks').get();

    taskTitle = snap.docs.map((doc) => doc['title'] as String).toList();
    taskIds = snap.docs.map((doc) => doc.id).toList();
  }

  List<Color> itemColors = [
    const Color(0xFFEBFFD7),
    const Color(0xFFFEEEDF),
    const Color(0xFFFBFBFB),
  ];

  Future<void> fetchData() async {
    await fetchingTasks();

    await userProjects();
  }

  @override
  void initState() {
    fetchData();
    fetchingTasks();
    userProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: const Text('Home'),
        actions: [
          const Icon(Icons.search),
          Padding(
            padding:
                const EdgeInsets.only(right: 10, top: 10, bottom: 6, left: 10),
            child: Container(
              width: getwidth(context) * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.0,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Quick Access',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const Divider(
                  color: Colors.black,
                ),
                FutureBuilder(
                  future: userProjects(),
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: getHeight(context) * 0.2,
                      width: getwidth(context),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: projectIds.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DisplayModules(
                                      pro_ID: projectIds[index],
                                    ),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 5,
                                color: itemColors[index % itemColors.length],
                                child: Container(
                                  width: getwidth(context) * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              projectNames[index],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF3A3A3A)),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Module - ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFACACAC)),
                                              ),
                                              Text(
                                                ' ${modIDsList.length}',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFACACAC),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [Text('65%')],
                                        ),
                                        Container(
                                          height: 3,
                                          decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        SizedBox(
                                          height: getHeight(context) * 0.02,
                                        ),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.timer_sharp,
                                              size: 16,
                                              color: Color(0xFF9A9A9A),
                                            ),
                                            Text(
                                              ' swork in progress',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF9A9A9A)),
                                            ),
                                            Spacer()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const Text(
                  'Recent Tasks',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const Divider(
                  color: Colors.black,
                ),
                FutureBuilder(
                  future: fetchingTasks(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: taskIds.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            bottom: 15,
                          ),
                          child: Material(
                            elevation: 30,
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: getHeight(context) * 0.09,
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
                                                taskTitle[index],
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
                                              Text(
                                                'Due date',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xFFA4A4A4)),
                                              ),
                                              Text(
                                                'Work In Progress',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xFF75A143)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
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
              builder: (context) => const AdProject(),
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
