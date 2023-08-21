import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamController {
  Future<String> createTeam(
      [String? teamName, String? teamLead, List<String>? members]) async {
    Map<String, dynamic> payload = {
      'name': teamName,
      'teamHead': FirebaseAuth.instance.currentUser!.uid,
      'teamLead': teamLead,
      'members': members
    };
    dynamic response =
        await FirebaseFirestore.instance.collection('teams').add(payload);

    return response.id.toString();
  }

  Future<List<Map<String, dynamic>>> getTeamsData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('teams').get();

    final allData = querySnapshot.docs.map((doc) {
      var data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
    allData;
    return allData;
  }
}
