import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth/register/register.dart';
import 'createteam.dart';

class MembersList extends StatefulWidget {
  const MembersList({super.key});

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  List<String>? userName = [];
  List<String>? userIds = [];
  List<String>? userEmail = [];
  Future<void> fetchingAllUssers() async {
    QuerySnapshot<Map<String, dynamic>> moduleSnapshot =
        await FirebaseFirestore.instance.collection('userData').get();

    userName =
        moduleSnapshot.docs.map((doc) => doc['fullName'] as String).toList();
    userIds =
        moduleSnapshot.docs.map((doc) => doc['userId'] as String).toList();
    userEmail =
        moduleSnapshot.docs.map((doc) => doc['email'] as String).toList();
  }

  @override
  void initState() {
    fetchingAllUssers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchingAllUssers(),
      builder: (context, snapshot) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: userIds!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  leadController.text = userName![index];
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                          userName![index],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3A3A3A),
                          ),
                        ),
                        Text(
                          userEmail![index],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF575757),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print(userIds![index]);
                            setState(() {
                              if (selectedMembers!.contains(userIds![index])) {
                                selectedMembers!.remove(userIds![index]);
                              } else {
                                selectedMembers!.add(userIds![index]);
                              }
                            });
                          },
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color:
                                    selectedMembers!.contains(userIds![index])
                                        ? const Color(0xFF92BB64)
                                        : Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
