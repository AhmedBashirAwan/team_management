import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/globals.dart';
import 'package:team_management/src/projects/screens/moduels.dart';

import '../../auth/register/register.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final projectTitleController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: getHeight(context) * 0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'New Project',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: getHeight(context) * 0.03,
              ),
              Row(
                children: [
                  Text(
                    'Task Title',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.015,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {},
                        controller: projectTitleController,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: 'Name your Project.',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                    width: getwidth(context) * 0.4,
                    height: getHeight(context) * 0.055,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        String projectId = await createProject(
                          projectTitleController.text.trim(),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Moduels(
                              projectId: projectId,
                            ),
                          ),
                        );
                        print(projectId);
                      },
                    )),
              ),
              SizedBox(
                height: getHeight(context) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
