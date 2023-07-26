import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/src/auth/register/register.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

final firstnameController = TextEditingController();
final lastnameController = TextEditingController();

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _CreateAccountState extends State<CreateAccount> {
  bool _isChecked = false;

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   lastnameController.dispose();
  //   firstnameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
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
                      icon: Icon(Icons.arrow_back))
                ],
              ),
              Row(
                children: [
                  Text(
                    'Create an Account,',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Text(
                'Create an account, it less then a minute. enter your email and password.',
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
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {},
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: '  First Name',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
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
                          hintText: '  Last Name ',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
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
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        onSubmitted: (value) {},
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: '  Email',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
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
                        icon: const Icon(Icons.check_circle_outline_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              Container(
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
                        controller: passwordController,
                        onSubmitted: (value) {},
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: '  Password',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
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
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Text('I agree with terms and conditions'),
                ],
              ),
              CustomButtons(
                buttonText: "Create An Account",
                onPressed: () async {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Verification(),
                  //   ),
                  // );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'By continuing, you agree to our ',
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Privacy Policy ',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'and ',
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'terms of service.',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
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
