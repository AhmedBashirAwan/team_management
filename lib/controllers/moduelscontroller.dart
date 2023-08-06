import 'package:cloud_firestore/cloud_firestore.dart';

class ModuleController {
  Future<String?> addModuels(String moduelTitle, String projectId) async {
    Map<String, dynamic> payload = {
      'title': moduelTitle,
      'project_ID': projectId,
    };
    await FirebaseFirestore.instance.collection('moduels').add(payload);
    return null;
  }

  Future<List<Map<String, dynamic>>> getModuleData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('moduels').get();

    List<Map<String, dynamic>> moduels = [];

    for (var doc in querySnapshot.docs) {
      moduels.add(doc.data());
    }

    return moduels;
  }
}
