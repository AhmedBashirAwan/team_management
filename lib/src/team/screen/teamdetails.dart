// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/team/screen/addmembers.dart';

class TeamDetails extends StatefulWidget {
  const TeamDetails({Key? key, required this.teamID}) : super(key: key);
  final String teamID;

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  late String teamLead;
  late String teamHead;
  late String teamName;
  late List<String>? currentMembers = [];
  late List<String>? memNames = [];
  late List<String>? allUsersList = [];
  Future<void> fetchingTeamsDetails() async {
    //getting all the data from the team docs
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('teams')
        .doc(widget.teamID)
        .get();
    teamName = snap['name'];

    //converting teamLead uerID to Name
    String lead = snap['teamLead'];
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('userData')
        .where('userId', isEqualTo: lead)
        .get();
    if (query.docs.isNotEmpty) {
      teamLead = query.docs[0]['fullName'];
    }

    //converting teamHeads userId to Name
    String head = snap['teamHead'];
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('userData')
        .where('userId', isEqualTo: head)
        .get();
    if (data.docs.isNotEmpty) {
      teamHead = query.docs[0]['fullName'];
    }

    //getting teamMemberUID
    dynamic teamData = snap.data();
    for (var element in teamData['members']) {
      currentMembers!.add(element['user_ID']);
    }

    //coverting these UIDS to a names
    for (var mem in currentMembers!) {
      QuerySnapshot<Map<String, dynamic>> memSnap = await FirebaseFirestore
          .instance
          .collection('userData')
          .where('userId', isEqualTo: mem)
          .get();

      memNames!.add(memSnap.docs[0]['fullName'] as String);
    }
  }

  Future<void> deleteMember(String selectedGuy) async {
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('teams')
        .doc(widget.teamID)
        .get();
    Map<String, dynamic>? snapData = snap.data();

    List<dynamic>? members = snapData?['members']?.cast<String>();
    members?.remove(selectedGuy);

    await FirebaseFirestore.instance
        .collection('teams')
        .doc(widget.teamID)
        .update({
      'members': members,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder<void>(
          future: fetchingTeamsDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                      const Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Team Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            teamName,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Team head',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Team lead',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  teamHead,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  teamLead,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          'Team Members',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddMembers(teamId: widget.teamID),
                                ),
                              );
                            },
                            child: const Icon(Icons.add)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: memNames!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        memNames![index],
                                      ),
                                      const Text(
                                        'Status',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      // deleteMember(currentMembers![index]);
                                    },
                                    child: const Icon(
                                      Icons.minimize,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
