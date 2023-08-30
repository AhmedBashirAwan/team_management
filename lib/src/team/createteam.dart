import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/controllers/teamcontroller.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/team/memberslist.dart';
import '../auth/register/register.dart';

TextEditingController leadController = TextEditingController();
List<String>? selectedMembers = [];

class AddTeam extends StatefulWidget {
  const AddTeam({super.key});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  bool isCheck = false;
  TextEditingController teamController = TextEditingController();

  List<String>? selectedIds = [];
  List<String>? selectedNames = [];
  List<String>? selectedEmails = [];

  Future<void> selectedMembersData() async {
    selectedNames = []; // Clear previous data before appending
    selectedIds = [];
    selectedEmails = [];

    for (var element in selectedMembers!) {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('userData')
          .where('userId', isEqualTo: element)
          .get();

      selectedNames?.addAll(snap.docs.map((doc) => doc['fullName'] as String));
      selectedIds?.addAll(snap.docs.map((doc) => doc['userId'] as String));
      selectedEmails?.addAll(snap.docs.map((doc) => doc['email'] as String));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: const Text('Create new Team'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  TeamController().createTeam(teamController.text.trim(),
                      leadController.text.trim(), selectedMembers);
                },
                child: const Text('Create')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'Team Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.04,
                child: TextField(
                  controller: teamController,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      hintText: 'Enter your Team Name',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Team Lead',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.04,
                child: TextField(
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  onTap: () {
                    teamLeadBottomSheet(context);
                  },
                  controller: leadController,
                  readOnly: true,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: 'Select lead',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Select Members',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        _showBottomSheet(context);
                        setState(() {
                          selectedMembers;
                        });
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: selectedMembersData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Data is being fetched, show a loading indicator or placeholder
                    return CircularProgressIndicator(); // Replace with your loading widget
                  } else if (snapshot.hasError) {
                    // Error occurred while fetching data
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: selectedMembers!.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // userIds.remove(userID);
                            // userName.remove(userName[index]);
                            // userEmail.remove(userEmail[index]);
                            // print(userID);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Material(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        margin: const EdgeInsets.only(left: 5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            'https://i2-prod.gazettelive.co.uk/incoming/article20679579.ece/ALTERNATES/s615b/0_jwr_mga_260521willowgracecampbell.jpg',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                selectedNames![index],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            selectedEmails![index],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void teamLeadBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
                    controller: leadController,
                    decoration: const InputDecoration(
                      hintText: 'Select a Team Member',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: selectedIds!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              leadController.text = selectedNames![index];
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: getHeight(context) * 0.05,
                                  width: getwidth(context) * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(
                                    'https://i2-prod.gazettelive.co.uk/incoming/article20679579.ece/ALTERNATES/s615b/0_jwr_mga_260521willowgracecampbell.jpg',
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedNames![index],
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF3A3A3A),
                                      ),
                                    ),
                                    Text(
                                      selectedEmails![index],
                                      style: const TextStyle(
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
                Text(
                  'Select Members',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Divider(
                  thickness: 1,
                ),
                MembersList(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                  child: CustomButtons(
                      buttonText: 'Add Members',
                      onPressed: () {
                        selectedMembersData();
                        setState(() {
                          selectedMembers;
                        });
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
    setState(() {
      selectedMembers;
    });
  }
}
