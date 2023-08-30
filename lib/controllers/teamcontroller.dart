import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamController {
  Future<void> createTeam(
      [String? teamName, String? teamLead, List<String>? members]) async {
    Map<String, dynamic> payload = {
      'name': teamName,
      'teamLead': teamLead,
      'teamHead': FirebaseAuth.instance.currentUser!.uid,
    };

    List<Map<String, dynamic>> memberList = [];
    if (members != null) {
      print(members.length);
      for (var element in members) {
        Map<String, dynamic> memberData = {
          'user_ID': element,
          'status': true,
        };
        memberList.add(memberData);
      }
      payload['members'] = memberList;
      await FirebaseFirestore.instance.collection('teams').add(payload);
    }
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
