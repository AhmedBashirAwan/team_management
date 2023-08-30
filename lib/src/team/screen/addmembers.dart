import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../chating/components/teamlist.dart';

// ignore: must_be_immutable
class AddMembers extends StatefulWidget {
  String teamId;
  AddMembers({Key? key, required this.teamId}) : super(key: key);

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final TextEditingController _searchController = TextEditingController();

  List<String> selectedMembers = [FirebaseAuth.instance.currentUser!.uid];

  Future<void> addMembers() async {
    List<Map<String, dynamic>> membersArray = [];

    for (var element in selectedMembers) {
      Map<String, dynamic> memberData = {
        'user_ID': element,
        'status': true,
      };
      membersArray.add(memberData);
    }

    await FirebaseFirestore.instance
        .collection('teams')
        .doc(widget.teamId)
        .update({
      'members': FieldValue.arrayUnion(membersArray),
    });
  }

  static Future<List<Map<String, dynamic>>> getUsersList() async {
    List<Map<String, dynamic>> userList = [];

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('userData').get();

      for (var doc in snapshot.docs) {
        userList.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error reading data from Firestore: $e');
    }

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Management'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'Add Members to Your Team',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.001,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
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
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getUsersList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error occurred'),
                  );
                }
                List<Map<String, dynamic>> userDataList = snapshot.data ?? [];
                userDataList = userDataList
                    .where((userData) =>
                        userData['userId'] !=
                        FirebaseAuth.instance.currentUser!.uid)
                    .toList();

                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: userDataList.length,
                    itemBuilder: (context, index) {
                      var userData = userDataList[index];

                      return GestureDetector(
                        onTap: () {
                          selectedMembers.add(userData['userId']);
                        },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            userData['fullName'] ?? '',
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
                                        userData['email'] ?? '',
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
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    addMembers();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamList(
                          selectedMembers: selectedMembers,
                          teamId: widget.teamId,
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
