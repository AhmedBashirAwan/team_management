// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/auth/wellcome/screen/welcom.dart';
import '../../../../controllers/usercontroller.dart';
import '../../../../globals.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _passwordVisible = false;
  bool _isChecked = false;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final languagesController = TextEditingController();
  final technologiesController = TextEditingController();
  String _emailError = '';

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailError = 'Please enter an email address';
      });
    } else {
      final emailRegExp =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      if (!emailRegExp.hasMatch(value)) {
        setState(() {
          _emailError = 'Please enter a valid email address';
        });
      } else {
        setState(() {
          _emailError = '';
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
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
                builder: (context) => const WelcomeScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Create an Account,',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Text(
                'It less then a minute. enter your email and password.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
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
                        // maxLength: 12,
                        controller: fullNameController,
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: const Color(0xFF92BB64),
                        decoration: InputDecoration(
                          hintText: 'Name',
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
                        icon: const Icon(Icons.check_circle_outline_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
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
                        onChanged: _validateEmail,
                        controller: emailController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: const Color(0xFF92BB64),
                        decoration: InputDecoration(
                          hintText: 'Email',
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
                        icon: const Icon(Icons.check_circle_outline_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
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
                        controller: passwordController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: const Color(0xFF92BB64),
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                        onPressed: () {
                          setState(() {
                            _passwordVisible =
                                !_passwordVisible; // Toggle password visibility
                          });
                        },
                        icon: Icon(_passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
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
                        readOnly: true,
                        controller: technologiesController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: const Color(0xFF92BB64),
                        decoration: InputDecoration(
                          hintText: 'Role in Organization',
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
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          technologiesController.text = value;
                        });
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'Employee',
                          child: Text('Employee'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Manager',
                          child: Text('Manger'),
                        ),
                      ],
                      child: const Icon(Icons.arrow_drop_down_outlined),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: getHeight(context) * 0.02,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //       color: Colors.grey,
              //       width: 1.0,
              //     ),
              //   ),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: getwidth(context) * 0.03,
              //       ),
              //       Expanded(
              //         child: TextField(
              //           controller: languagesController,
              //           onSubmitted: (value) {},
              //           style: Theme.of(context).textTheme.titleSmall,
              //           cursorColor: const Color(0xFF92BB64),
              //           decoration: InputDecoration(
              //             hintText: 'Languages',
              //             hintStyle: Theme.of(context).textTheme.titleSmall,
              //             enabledBorder: const UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.transparent),
              //             ),
              //             focusedBorder: const UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.transparent),
              //             ),
              //             disabledBorder: const UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.transparent),
              //             ),
              //             enabled: isReadOnly,
              //           ),
              //         ),
              //       ),
              //       IconTheme(
              //         data: IconThemeData(color: Colors.blue.shade700),
              //         child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.arrow_drop_down),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: const Color(0xFF92BB64),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text('I agree with terms and conditions'),
                ],
              ),
              SizedBox(
                height: getHeight(context) * 0.01,
              ),
              CustomButtons(
                buttonText: "Create An Account",
                onPressed: _isChecked
                    ? () async {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        USER_ID = userCredential.user!.uid;
                        await UserController().addUserDetails(
                            fullName: fullNameController.text.trim(),
                            email: emailController.text.trim(),
                            roles: technologiesController.text.trim());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      }
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account? ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF92BB64),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
