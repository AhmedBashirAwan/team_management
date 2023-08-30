import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_management/controllers/assignmentcontroller.dart';
import 'package:team_management/controllers/taskscontroller.dart';
import '../auth/register/register.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  String assignTo = '';
  TextEditingController assignToController = TextEditingController();
  DateTime? pickedDate;
  String dueDate = '';
  String? selectedPriority;

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

  TextEditingController _taskDescription = TextEditingController();
  TextEditingController _taskTitle = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: const Text('Add New Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(context) * 0.05,
                child: TextField(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                  controller: _taskTitle,
                  decoration: const InputDecoration(
                      hintText: 'Task name',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Text(
                      'TimeLine',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBFFD7),
                          foregroundColor: Colors.black,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          await dateTimePicker();
                        },
                        child: const Text('Set Date')),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.01,
              ),
              const Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Spacer(),
                  Text('Edit')
                ],
              ),
              Container(
                width: getwidth(context) * 0.88,
                height: getHeight(context) * 0.11,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 10, bottom: 10, top: 15),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                    controller: _taskDescription,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 12),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      hintMaxLines: 3,
                      hintText:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Priority',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE2C8),
                        foregroundColor: Colors.black,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedPriority = 'High';
                        });
                      },
                      child: const Text('High')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEEEDF),
                          foregroundColor: Colors.black,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedPriority = 'Medium';
                          });
                        },
                        child: const Text('Medium')),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEEEDF),
                        foregroundColor: Colors.black,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedPriority = 'low';
                        });
                      },
                      child: const Text('Low')),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Attachment',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DottedBorder(
                  dashPattern: const [5, 5],
                  color: const Color(0xFF75A143),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: getHeight(context) * 0.07,
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
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Text(
                      'Invited Members',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF575757)),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFEBFFD7),
                    borderRadius: BorderRadius.circular(7)),
                height: getHeight(context) * 0.05,
                child: Row(
                  children: [
                    Text(assignTo.isNotEmpty
                        ? assignToController.text
                        : 'Select A Member'),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          teamLeadBottomSheet(context);
                        },
                        child: const Icon(Icons.arrow_drop_down))
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 7),
              //   child: SizedBox(
              //     width: getwidth(context),
              //     child: Row(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: Container(
              //             height: getHeight(context) * 0.045,
              //             width: getwidth(context) * 0.24,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: const Color(0xFFFEEEDF)),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 7),
              //               child: Row(
              //                 children: [
              //                   Text('Sam S'),
              //                   Spacer(),
              //                   Icon(
              //                     Icons.close,
              //                     size: 18,
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: getHeight(context) * 0.045,
              //           width: getwidth(context) * 0.24,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(20),
              //               color: const Color(0xFFFEEEDF)),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 7),
              //             child: Row(
              //               children: [
              //                 Text('Sam S'),
              //                 Spacer(),
              //                 Icon(
              //                   Icons.close,
              //                   size: 18,
              //                 )
              //               ],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: getHeight(context) * 0.1,
              ),
              SizedBox(
                height: getHeight(context) * 0.06,
                width: getwidth(context),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF92BB64),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      String? newTask = await TasksController().addTasks(
                        tasksTitle: _taskTitle.text.trim(),
                        modId: 'widget.mod_ID',
                        projectID: 'widget.pro_ID',
                        taskDescription: _taskDescription.text.trim(),
                      );
                      await AssignmentController().createAssignments(
                          priority: selectedPriority,
                          assignTo: assignToController.text.trim(),
                          dueDate: dueDate.toString(),
                          taskID: newTask);
                    },
                    child: const Text('Add Task')),
              ),
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
}
