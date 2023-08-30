import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> aLLAssignedTasks = [];
List<String> highPriorityTasks = [];
List<String> lowPriorityTasks = [];
List<String> mediumPriorityTasks = [];
List<String> incompleteTasks = [];
List<String> completeTasks = [];

class DashboardController {
  Future<void> fetchingEveryAssignment() async {
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    aLLAssignedTasks =
        snap.docs.map((doc) => doc['task_ID'] as String).toList();
    aLLAssignedTasks;
    print(aLLAssignedTasks);

    QuerySnapshot<Map<String, dynamic>> highSnap = await FirebaseFirestore
        .instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('priority', isEqualTo: 'High')
        .get();
    highPriorityTasks =
        highSnap.docs.map((doc) => doc['task_ID'] as String).toList();

    QuerySnapshot<Map<String, dynamic>> lowSnap = await FirebaseFirestore
        .instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('priority', isEqualTo: 'Low')
        .get();
    lowPriorityTasks =
        lowSnap.docs.map((doc) => doc['task_ID'] as String).toList();

    QuerySnapshot<Map<String, dynamic>> mediumSnap = await FirebaseFirestore
        .instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('priority', isEqualTo: 'Medium')
        .get();
    mediumPriorityTasks =
        mediumSnap.docs.map((doc) => doc['task_ID'] as String).toList();

    QuerySnapshot<Map<String, dynamic>> falseSnap = await FirebaseFirestore
        .instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: false)
        .get();
    incompleteTasks =
        falseSnap.docs.map((doc) => doc['task_ID'] as String).toList();

    QuerySnapshot<Map<String, dynamic>> trueSnap = await FirebaseFirestore
        .instance
        .collection('assignments')
        .where('assign_to', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: true)
        .get();
    completeTasks =
        trueSnap.docs.map((doc) => doc['task_ID'] as String).toList();
  }
}
