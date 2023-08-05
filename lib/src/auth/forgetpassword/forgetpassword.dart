import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';

import '../login/screen/login.dart';
import '../register/register.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Forget Password',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Don\'t worry! It happens. Please enter the address associated with your Account.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: getwidth(context) * 0.03,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      IconTheme(
                        data: IconThemeData(color: Colors.blue.shade700),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.alternate_email_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              CustomButtons(
                buttonText: 'Send Code',
                onPressed: () async {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emailController.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
