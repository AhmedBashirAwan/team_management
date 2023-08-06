import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationController {
  Future<String?> addTasks(
    String organizationName,
  ) async {
    Map<String, dynamic> payload = {
      'name': organizationName,
    };
    await FirebaseFirestore.instance.collection('organizations').add(payload);
    return null;
  }

  Future<List<Map<String, dynamic>>> getOrganizationData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('organizations').get();

    List<Map<String, dynamic>> organizations = [];

    for (var doc in querySnapshot.docs) {
      organizations.add(doc.data());
    }

    return organizations;
  }
}
