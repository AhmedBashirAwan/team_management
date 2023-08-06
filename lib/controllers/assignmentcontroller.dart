import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentController {
  Future<String> createAssignments(String assignTo, String from, bool status,
      String taskID, Timestamp completedAt, Timestamp dueDate) async {
    Map<String, dynamic> payload = {
      'assign_to': assignTo,
      'completedAt': completedAt,
      'dueDate': dueDate,
      'from': from,
      'status': status,
      'task_ID': taskID,
    };
    dynamic response =
        await FirebaseFirestore.instance.collection('assignments').add(payload);

    return response.id.toString();
  }

  Future<List<Map<String, dynamic>>> getAssignmentsData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('assignments').get();

    List<Map<String, dynamic>> assignments = [];

    for (var doc in querySnapshot.docs) {
      assignments.add(doc.data());
    }

    return assignments;
  }
}
