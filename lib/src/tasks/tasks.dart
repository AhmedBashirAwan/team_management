import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/taskscontroller.dart';
import '../Dashboard/screen/dashboard.dart';
import '../auth/register/register.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key, required this.modueld, required this.projectID})
      : super(key: key);
  final String modueld;
  final String projectID;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final _titleController = TextEditingController();
  final toController = TextEditingController();
  final _descriptionController = TextEditingController();
  final dateController = TextEditingController();
  List<String> task_ID = [];
  List<String> taskTitle = [];
  List<String> taskDescription = [];
  bool status = false;
  DateTime? pickedDate;
  List<String> teamMembers = [];
  late String assignTo;

  Future<List<String>> getTasksData(String modID) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('mod_ID', isEqualTo: modID)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      taskTitle =
          querySnapshot.docs.map((doc) => doc['title'] as String).toList();
      taskDescription = querySnapshot.docs
          .map((doc) => doc['description'] as String)
          .toList();
      task_ID = querySnapshot.docs.map((doc) => doc.id).toList();
    } else {
      print("No tasks found for the module");
    }
    return taskTitle;
  }

  Future<void> dateTimePicker() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  Future<String> createAssignments(String? taskID) async {
    Map<String, dynamic> payload = {
      'assign_to': assignTo,
      // 'completedAt': completedAt,
      'task_ID': taskID,
      'status': status,
      'dueDate': pickedDate,
      'from': FirebaseAuth.instance.currentUser!.uid,
    };
    dynamic response =
        await FirebaseFirestore.instance.collection('assignments').add(payload);
    return response.id.toString();
  }

  Future<void> fetchingTeamMembers() async {
    // Fetch the project document
    DocumentSnapshot<Map<String, dynamic>> projectSnapshot =
        await FirebaseFirestore.instance
            .collection('projects')
            .doc(widget.projectID)
            .get();

    // Get the team ID from the project data
    String? teamID = projectSnapshot.data()?['team_ID'];

    // Fetch the team document using the team ID
    if (teamID != null) {
      DocumentSnapshot<Map<String, dynamic>> teamSnapshot =
          await FirebaseFirestore.instance
              .collection('teams')
              .doc(teamID)
              .get();

      // Get the members array from the team data
      List<dynamic> members = teamSnapshot.data()?['members'] ?? [];

      // Iterate through members array to fetch user data and add names to the list
      for (var member in members) {
        String personID = member['user_ID']; // Assuming your field is 'user_ID'

        QuerySnapshot<Map<String, dynamic>> userDataQuerySnapshot =
            await FirebaseFirestore.instance
                .collection('userData')
                .where('userId', isEqualTo: personID)
                .get();

        // Check if user data was found and add the full name to the list
        if (userDataQuerySnapshot.size > 0) {
          String fullName = userDataQuerySnapshot.docs[0].data()?['fullName'] ??
              "No name available";
          teamMembers.add(fullName);
        } else {
          print("User data not found for person with ID: $personID");
        }
      }
      print(teamMembers);
    } else {
      print("No team ID found in project data.");
    }
  }

  Future<void> getAssignId() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('userData')
        .where('fullName', isEqualTo: toController.text.trim())
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      assignTo = userQuerySnapshot.docs.first.get('userId');

      print('Assign to: $assignTo');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchingTeamMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: getHeight(context) * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 10,
                color: Colors.grey.shade300,
                child: SizedBox(
                  height: getHeight(context) * 0.075,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Tasks in the Module',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                height: getHeight(context) * 0.78,
                child: FutureBuilder(
                  future: getTasksData(widget.modueld.toString()),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: taskTitle.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: getHeight(context) * 0.08,
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getwidth(context) * 0.05,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      taskTitle[index],
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(taskDescription[index]),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      String taskIDS = task_ID[index];
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Column(
                                                children: [
                                                  const Text(
                                                    'Due Date',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  TextField(
                                                      controller:
                                                          dateController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: 'yyyy-MM-dd',
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      readOnly: true,
                                                      onTap: () async {
                                                        dateTimePicker();
                                                      }),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text(
                                                    'Assiged To',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  TextField(
                                                      controller: toController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Members name',
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      readOnly: true,
                                                      onTap: () async {
                                                        showPopupMenu(context);
                                                      })
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await getAssignId();
                                                      await createAssignments(
                                                          taskIDS);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Assign'))
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.more_vert))
                              ],
                            ));
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: getHeight(context) * 0.07,
                    width: getwidth(context) * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.white),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back)),
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                children: [
                                  const Text(
                                    'Task Title',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  TextField(
                                    onSubmitted: (value) async {
                                      await TasksController().addTasks(
                                          _titleController.text.trim(),
                                          widget.modueld,
                                          _descriptionController.text.trim(),
                                          widget.projectID);
                                      Navigator.pop(context);
                                    },
                                    controller: _titleController,
                                    style: const TextStyle(fontSize: 20),
                                    autocorrect: true,
                                    decoration: const InputDecoration(
                                      hintText: 'e.g, Appbars.',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Enter Description',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  TextField(
                                    onSubmitted: (value) async {
                                      await TasksController().addTasks(
                                          _titleController.text.trim(),
                                          widget.modueld,
                                          _descriptionController.text.trim(),
                                          widget.projectID);
                                      Navigator.pop(context);
                                    },
                                    controller: _descriptionController,
                                    style: const TextStyle(fontSize: 20),
                                    autocorrect: true,
                                    decoration: const InputDecoration(
                                      hintText: 'complete the task',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await TasksController().addTasks(
                                          _titleController.text.trim(),
                                          widget.modueld,
                                          _descriptionController.text.trim(),
                                          widget.projectID);
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    child: const Text('Add'))
                              ],
                            );
                          });
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showPopupMenu(BuildContext context) async {
    final selectedValue = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: teamMembers.map((String item) {
        return PopupMenuItem<String>(
          child: Text(item),
          value: item,
        );
      }).toList(),
    );

    if (selectedValue != null) {
      setState(() {
        toController.text = selectedValue;
      });
    }
  }
}
