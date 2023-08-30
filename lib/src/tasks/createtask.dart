// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_management/controllers/assignmentcontroller.dart';
import 'package:team_management/controllers/taskscontroller.dart';
import 'package:team_management/src/auth/register/register.dart';

class CreateProject extends StatefulWidget {
  CreateProject({super.key, required this.pro_ID, required this.mod_ID});
  String mod_ID;
  String pro_ID;

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  DateTime? pickedDate;
  String assignTo = '';
  late String priority;
  TextEditingController assignToController = TextEditingController();
  TextEditingController _taskDescription = TextEditingController();
  TextEditingController _taskTitle = TextEditingController();
  TextEditingController _projectName = TextEditingController();
  List<String> priorityOptions = ['Medium', 'High', 'Low'];
  String? selectedPriority;
  String dueDate = '';

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

  TextEditingController leadController = TextEditingController();
  List<String> selectedMembers = [];

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

  Future<void> dateTimePicker() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      setState(() {
        dueDate = formattedDate;
      });
    }
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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
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
                onPressed: () async {
                  String? newTask = await TasksController().addTasks(
                    tasksTitle: _taskTitle.text.trim(),
                    modId: widget.mod_ID,
                    projectID: widget.pro_ID,
                    taskDescription: _taskDescription.text.trim(),
                  );

                  await AssignmentController().createAssignments(
                      priority: selectedPriority,
                      assignTo: assignToController.text.trim(),
                      dueDate: dueDate.toString(),
                      taskID: newTask);
                },
                child: const Text('Create')),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(top: 5),
            //   child: Row(
            //     children: [
            //       Text(
            //         'Project',
            //         style: TextStyle(
            //             fontFamily: 'Poppins',
            //             fontSize: 12,
            //             fontWeight: FontWeight.w500,
            //             color: Color(0xFF575757)),
            //       ),
            //     ],
            //   ),
            // ),

            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Text(
                    'Task',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.05,
              child: TextField(
                onTap: () {},
                controller: _taskTitle,
                decoration: const InputDecoration(
                    hintText: 'Task Title',
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            Container(
              height: getHeight(context) * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _taskDescription,
                  decoration: const InputDecoration(
                      hintText: 'Add Description',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: DottedBorder(
                dashPattern: [5, 5],
                color: const Color(0xFF75A143),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: getHeight(context) * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        color: Color(0xFF979797),
                      ),
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Drop files to attach or ',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF979797))),
                        TextSpan(
                            text: 'Browse',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF75A143)))
                      ]))
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    'Assignee',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: getHeight(context) * 0.035,
                child: TextField(
                  controller: assignToController,
                  onTap: () {
                    teamLeadBottomSheet(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      suffixIconColor: Color(0xFFA8A8A8),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                      hintText: 'UnAssigned',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Periority',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF575757)),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: getHeight(context) * 0.04,
                    child: DropdownButton<String>(
                      value: selectedPriority,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.arrow_drop_down_outlined),
                        ],
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPriority = newValue!;
                          print(selectedPriority);
                        });
                      },
                      items: priorityOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text(
                        'Medium',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Row(
                children: [
                  Text(
                    'TimeLine',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF575757)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF92BB64), // Background color
                        foregroundColor: Colors.white, // Text color
                        elevation: 5, // Elevation (shadow)
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Border radius
                        ),
                      ),
                      onPressed: () async {
                        await dateTimePicker();
                      },
                      child: const Text('Set Due Date')),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void teamLeadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: getHeight(context) * 0.5,
          child: FutureBuilder(
              future: fetchingAllUssers(),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: getHeight(context) * 0.04,
                        child: TextField(
                          controller: assignToController,
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: userIds!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                assignToController.text = userName![index];
                                assignTo = userIds![index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: getHeight(context) * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: getHeight(context) * 0.04,
                  child: TextField(
                    controller: _projectName,
                    decoration: const InputDecoration(
                      hintText: '  Enter your Project Name',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: projectIds.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _projectName.text = projectNames[index];
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
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  projectNames[index],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF3A3A3A),
                                  ),
                                ),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _members(BuildContext context) {
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
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    controller: _projectName,
                    decoration: const InputDecoration(
                        hintText: '  Enter your Project Name',
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Landing Page Design',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Landing Page Design',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
