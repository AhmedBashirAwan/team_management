import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AssignmentController {
  Future<String> createAssignments(
      [String? assignTo,
      bool? status,
      String? from,
      String? taskID,
      Timestamp? completedAt,
      Timestamp? dueDate]) async {
    Map<String, dynamic> payload = {
      'assign_to': assignTo,
      'completedAt': completedAt,
      'dueDate': dueDate,
      'status': status,
      'task_ID': taskID,
      'from': FirebaseAuth.instance.currentUser!.uid,
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
