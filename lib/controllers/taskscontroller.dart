import 'package:cloud_firestore/cloud_firestore.dart';

class TasksController {
  Future<String?> addTasks({
    String? tasksTitle,
    String? taskDescription,
    String? modId,
    String? projectID,
  }) async {
    try {
      Map<String, dynamic> payload = {
        'description': taskDescription,
        'mod_ID': modId,
        'pro_ID': projectID,
        'title': tasksTitle,
      };

      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('tasks').add(payload);

      String newDocId = docRef.id;

      return newDocId;
    } catch (error) {
      print('Error adding task: $error');
      return null;
    }
  }
}
