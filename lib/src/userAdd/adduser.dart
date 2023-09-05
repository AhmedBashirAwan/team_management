import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_management/controllers/usercontroller.dart';
import 'package:team_management/src/auth/register/register.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  TextEditingController emailController = TextEditingController();

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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchingAllUssers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Create Users'),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Current Employees',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.42,
                child: FutureBuilder(
                  future: fetchingAllUssers(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userIds!.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: SizedBox(
                            height: getHeight(context) * 0.07,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: getHeight(context) * 0.35,
                decoration: const BoxDecoration(
                    color: Color(0xFFFEEEDF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Employyees to Your',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Organization',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.02,
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getwidth(context) * 0.03,
                            ),
                            Expanded(
                              child: TextField(
                                controller: emailController,
                                onSubmitted: (value) {},
                                style: Theme.of(context).textTheme.titleSmall,
                                cursorColor: const Color(0xFF92BB64),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            IconTheme(
                              data:
                                  const IconThemeData(color: Color(0xFF92BB64)),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.check_circle_outline_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context) * 0.02,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: getwidth(context) * 0.4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF92BB64),
                              foregroundColor: Colors.white,
                              elevation: 5,
                              // padding:
                              //     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              await UserController().addUserDetails(
                                email: emailController.text.trim(),
                                roles: 'Employees',
                              );
                              await fetchingAllUssers();
                              dispose();
                            },
                            child: const Text('Add')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
