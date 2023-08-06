import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  Future<String?> getUserData() async {
    final getData = await FirebaseFirestore.instance
        .collection('userData')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    dynamic data = getData.docs.first.data();
    print(data['fullName']);
    return data['fullName'];
  }
}
