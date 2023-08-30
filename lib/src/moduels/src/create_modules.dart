// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:team_management/controllers/moduelscontroller.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import '../../../customised/widgets/bottomnavigation.dart';
import '../../auth/register/register.dart';
import '../components/all_modules.dart';

class CreateModules extends StatefulWidget {
  CreateModules({super.key, required this.pro_Id});
  String pro_Id;

  @override
  State<CreateModules> createState() => _CreateModulesState();
}

class _CreateModulesState extends State<CreateModules> {
  final moduleNameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text('Modules of Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(context) * 0.03,
            ),
            const Row(
              children: [
                Text(
                  'Module Name',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF575757)),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(context) * 0.035,
              child: TextField(
                controller: moduleNameController,
                cursorColor: const Color(0xFF92BB64),
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF75A143)),
                    ),
                    isDense: true,
                    hintText: 'Name Your Module',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.03,
            ),
            const Row(
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF575757)),
                ),
                Spacer(),
                Text('Edit')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: getwidth(context) * 0.88,
                height: getHeight(context) * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
                  child: TextField(
                    controller: descriptionController,
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                    maxLines: 8,
                    cursorColor: const Color(0xFF92BB64),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      hintText:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context) * 0.08,
            ),
            SizedBox(
              height: getHeight(context) * 0.06,
              child: CustomButtons(
                buttonText: 'Create Module',
                onPressed: () {
                  ModuleController().addModuels(
                      moduleNameController.text.trim(),
                      descriptionController.text.trim(),
                      widget.pro_Id.toString());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayModules(
                        pro_ID: widget.pro_Id,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
