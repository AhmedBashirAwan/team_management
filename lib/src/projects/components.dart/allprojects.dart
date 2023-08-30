import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/projects/components.dart/adproject.dart';
import '../../moduels/components/all_modules.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({super.key});

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
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

    modIDsList = [];
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

  @override
  void initState() {
    // userProjects();
    super.initState();
  }

  List<Color> itemColors = [
    const Color(0xFFEBFFD7),
    const Color(0xFFFEEEDF),
    const Color(0xFFFBFBFB),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: const Text('Projects'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Projects',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: getHeight(context) * 0.02,
                ),
                FutureBuilder(
                  future: userProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Data is being fetched, show a loading indicator or placeholder
                      return CircularProgressIndicator(); // Replace with your loading widget
                    } else if (snapshot.hasError) {
                      // Error occurred while fetching data
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: projectIds.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, right: 10),
                            child: InkWell(
                              onTap: () {
                                String pro_ID = projectIds[index];
                                print(modIDsList[index]);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DisplayModules(
                                      pro_ID: pro_ID,
                                    ),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 20,
                                borderRadius: BorderRadius.circular(20),
                                color: itemColors[index % itemColors.length],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: SizedBox(
                                    height: getHeight(context) * 0.14,
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
                                                ' ${modIDsList[index].length}', // Use the length of the module IDs list
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
                                              '  work in progress',
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
                      );
                    }
                  },
                ),
              ],
            )
          ],
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
