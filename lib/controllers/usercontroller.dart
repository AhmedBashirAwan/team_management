import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../globals.dart';

class UserController {
  Future<void> addUserDetails(String fullName, String email) async {
    Map<String, dynamic> payload = {
      'userId': USER_ID,
      'email': email,
      'fullName': fullName,
    };
    await FirebaseFirestore.instance.collection('userData').add(payload);
  }

  Future<String?> getUserData() async {
    try {
      final getData = await FirebaseFirestore.instance
          .collection('userData')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      dynamic data = getData.docs.first.data();
      return data['fullName'];
    } catch (e) {
      return "null name";
    }
  }

  Future<void> updateUserData(String newName) async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('userData')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDoc = userQuerySnapshot.docs.first;
      await userDoc.reference.update({'fullName': newName});
    }
  }
}
