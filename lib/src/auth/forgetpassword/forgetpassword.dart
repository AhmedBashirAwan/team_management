import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';

import '../login/screen/login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_back)))
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
                  'Dont worry! it happens. Please Enter the address associated to your Account',
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
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) {},
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            hintText: ' Email',
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
