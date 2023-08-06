import 'package:cloud_firestore/cloud_firestore.dart';

class TasksController {
  Future<String?> addTasks(
      String tasksTitle, String modId, String taskDescription) async {
    Map<String, dynamic> payload = {
      'description': taskDescription,
      'title': tasksTitle,
      'mod_ID': modId,
    };
    await FirebaseFirestore.instance.collection('tasks').add(payload);
    return null;
  }

  Future<List<Map<String, dynamic>>> getTasksData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    List<Map<String, dynamic>> tasks = [];

    for (var doc in querySnapshot.docs) {
      tasks.add(doc.data());
    }

    return tasks;
  }
}
