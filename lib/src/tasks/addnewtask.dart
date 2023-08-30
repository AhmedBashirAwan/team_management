import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../auth/register/register.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: const Icon(Icons.arrow_back),
        title: const Text('Add New Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(context) * 0.05,
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: 'Task name',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Text(
                      'TimeLine',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBFFD7),
                          foregroundColor: Colors.black,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Set Date')),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.01,
              ),
              const Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Spacer(),
                  Text('Edit')
                ],
              ),
              Container(
                width: getwidth(context) * 0.88,
                height: getHeight(context) * 0.11,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 12),
                      hintStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      hintMaxLines: 3,
                      hintText:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Priority',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE2C8),
                        foregroundColor: Colors.black,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('High')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEEEDF),
                          foregroundColor: Colors.black,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Medium')),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEEEDF),
                        foregroundColor: Colors.black,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Low')),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Attachment',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DottedBorder(
                  dashPattern: const [5, 5],
                  color: const Color(0xFF75A143),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: getHeight(context) * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.file_upload_outlined,
                          color: Color(0xFF979797),
                        ),
                        RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: 'Drop files to attach or ',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF979797))),
                          TextSpan(
                              text: 'Browse',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF75A143)))
                        ]))
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Text(
                      'Invited Members',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF575757)),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFEBFFD7),
                    borderRadius: BorderRadius.circular(7)),
                height: getHeight(context) * 0.05,
                child: const Row(
                  children: [
                    Text('Invited Members'),
                    Spacer(),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: SizedBox(
                  width: getwidth(context),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: getHeight(context) * 0.045,
                          width: getwidth(context) * 0.24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFFEEEDF)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Text('Sam S'),
                                Spacer(),
                                Icon(
                                  Icons.close,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: getHeight(context) * 0.045,
                        width: getwidth(context) * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFFEEEDF)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Row(
                            children: [
                              Text('Sam S'),
                              Spacer(),
                              Icon(
                                Icons.close,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.06,
                width: getwidth(context),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF92BB64),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Add Task')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
