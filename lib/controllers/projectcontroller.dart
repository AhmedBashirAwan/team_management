import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectController {
  Future<String> createProject([String? projectTitle, String? teamId]) async {
    Map<String, dynamic> payload = {
      'title': projectTitle,
      'created_by': FirebaseAuth.instance.currentUser!.uid,
      'team_ID': teamId
    };
    dynamic response =
        await FirebaseFirestore.instance.collection('projects').add(payload);

    return response.id.toString();
  }
}
