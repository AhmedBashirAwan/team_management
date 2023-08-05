import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectController {
  Future<String> createProject(
    String projectTitle,
  ) async {
    Map<String, dynamic> payload = {
      'title': projectTitle,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    };
    dynamic response =
        await FirebaseFirestore.instance.collection('projects').add(payload);

    return response.id.toString();
  }
}
