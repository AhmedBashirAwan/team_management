import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:team_management/controllers/usercontroller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? assetImagePath;
  TextEditingController nameEditingController = TextEditingController();
  bool isReadOnly = true;
  String? userData;
  PlatformFile? pickedFile;

  Future<void> uploadFile() async {
    if (pickedFile == null) {
      print('No file picked');
      return;
    }

    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    try {
      final userQuerySnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        final userDoc = userQuerySnapshot.docs.first;
        await userDoc.reference.update({'imageURL': urlDownload});
        print('URL saved in Firestore successfully!');
      } else {
        await FirebaseFirestore.instance.collection('userData').add({
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'imageURL': urlDownload,
        });
        print('New user document created with URL in Firestore!');
      }
    } catch (e) {
      print('Error saving URL in Firestore: $e');
    }
  }

  Future<void> loadAssetImage() async {
    ByteData data = await rootBundle.load('assets/images/person.png');
    List<int> bytes = data.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final assetImagePathInTempDir = '${tempDir.path}/asset_image.jpg';

    await File(assetImagePathInTempDir).writeAsBytes(bytes);

    setState(() {
      assetImagePath = assetImagePathInTempDir;
    });
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  void toggleReadOnly() {
    setState(() {
      isReadOnly = !isReadOnly;
    });
  }

  Future<void> updateName() async {
    await UserController().updateUserData(nameEditingController.text.trim());
    setState(() {
      userData = nameEditingController.text.trim();
    });
  }

  Future<void> getUserData() async {
    final data = await UserController().getUserData();
    setState(() {
      userData = data ?? 'No data available';
    });
  }

  @override
  void initState() {
    super.initState();
    pickedFile = null;
    loadAssetImage();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: selectFile,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: pickedFile != null
                  ? FileImage(File(pickedFile!.path!))
                  : (assetImagePath != null
                      ? FileImage(File(assetImagePath!))
                      : null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: FutureBuilder<String?>(
                    future: UserController().getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final userData = snapshot.data;
                        if (userData == null) {
                          return const Text('No data available');
                        }
                        return Text(
                          userData,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(
                  '${FirebaseAuth.instance.currentUser!.email}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<String?>(
                  future: UserController().getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userData = snapshot.data;
                      if (userData == null) {
                        return const Text('No data available');
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onSubmitted: (_) => updateName(),
                              style: Theme.of(context).textTheme.titleSmall,
                              controller: nameEditingController,
                              decoration: InputDecoration(
                                hintText: userData,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                                enabled: !isReadOnly,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: toggleReadOnly,
                            tooltip: isReadOnly
                                ? 'Enable Editing'
                                : 'Disable Editing',
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      '${FirebaseAuth.instance.currentUser!.email}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      iconSize: 30,
                      onPressed: () {},
                      icon: const Icon(Icons.mail_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  onPressed: pickedFile != null ? uploadFile : null,
                  child: const Text('Add Picture')))
        ],
      ),
    ));
  }
}
