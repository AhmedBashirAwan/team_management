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
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: getwidth(context) * 0.03,
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) async {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text.trim());
                        },
                        controller: _emailController,
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: const Color(0xFF92BB64),
                        decoration: InputDecoration(
                          hintText: 'jhon123@gmail.com',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
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
                    IconTheme(
                      data: const IconThemeData(color: Color(0xFF92BB64)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.alternate_email_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
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
