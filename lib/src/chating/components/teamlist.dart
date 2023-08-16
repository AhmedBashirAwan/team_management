import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';
import '../../Dashboard/screen/dashboard.dart';

// ignore: must_be_immutable
class TeamList extends StatefulWidget {
  List<String>? selectedMembers;
  String? teamId;
  TeamList({Key? key, this.selectedMembers, this.teamId}) : super(key: key);

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  List<String> teamMembers = [];
  List<Map<String, dynamic>> membersInfo = [];

  @override
  void initState() {
    super.initState();
    teamMembers = widget.selectedMembers ?? [];
    getTeamMembersInfo();
  }

  Future<String> createTeamLead(String teamLead) async {
    try {
      Map<String, dynamic> payload = {
        'teamLead': teamLead,
      };

      DocumentReference docRef =
          FirebaseFirestore.instance.collection('teams').doc(widget.teamId);
      await docRef.update(payload);

      return 'Team lead updated successfully';
    } catch (error) {
      return 'Error updating team lead: $error';
    }
  }

  Future<void> getTeamMembersInfo() async {
    membersInfo.clear();

    for (String memberId in teamMembers) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .where('userId', isEqualTo: memberId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        membersInfo.add(querySnapshot.docs[0].data() as Map<String, dynamic>);
      } else {
        print("Member with ID $memberId does not exist.");
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Team Members",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: getHeight(context) * 0.07,
            child: const Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Row(
                children: [
                  Text(
                    'Your Team Members',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.73,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: membersInfo.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> memberData = membersInfo[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Material(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(left: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://i2-prod.gazettelive.co.uk/incoming/article20679579.ece/ALTERNATES/s615b/0_jwr_mga_260521willowgracecampbell.jpg',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      memberData['fullName'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  memberData['email'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            PopupMenuButton(
                              child: const Center(child: Icon(Icons.more_vert)),
                              itemBuilder: (context) {
                                return List.generate(1, (index) {
                                  return PopupMenuItem(
                                    child: const Text(
                                      'Make team lead',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onTap: () async {
                                      await createTeamLead(
                                          memberData['userId']);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
