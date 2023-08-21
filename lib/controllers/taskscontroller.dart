import 'package:cloud_firestore/cloud_firestore.dart';

class TasksController {
  Future<String?> addTasks(String tasksTitle, String modId,
      String taskDescription, String projectID) async {
    Map<String, dynamic> payload = {
      'pro_ID': projectID,
      'description': taskDescription,
      'title': tasksTitle,
      'mod_ID': modId,
    };
    await FirebaseFirestore.instance.collection('tasks').add(payload);
    return null;
  }
}
