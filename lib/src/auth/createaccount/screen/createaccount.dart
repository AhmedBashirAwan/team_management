import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/src/auth/register/register.dart';
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
  // ignore: unused_field
  String _emailError = '';
  bool isReadOnly = true;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back))
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
                    SizedBox(
                      width: getwidth(context) * 0.03,
                    ),
                    Expanded(
                      child: TextField(
                        controller: fullNameController,
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: Colors.blue,
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
                    SizedBox(
                      width: getwidth(context) * 0.03,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: _validateEmail,
                        controller: emailController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: Colors.blue,
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
                    SizedBox(
                      width: getwidth(context) * 0.03,
                    ),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: Colors.blue,
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
                      data: IconThemeData(color: Colors.blue.shade700),
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
                        controller: technologiesController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: 'Technologies',
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
                          enabled: isReadOnly,
                        ),
                      ),
                    ),
                    IconTheme(
                      data: IconThemeData(color: Colors.blue.shade700),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isReadOnly = !isReadOnly;
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down),
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
                    SizedBox(
                      width: getwidth(context) * 0.03,
                    ),
                    Expanded(
                      child: TextField(
                        controller: languagesController,
                        onSubmitted: (value) {},
                        style: Theme.of(context).textTheme.titleSmall,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: 'Languages',
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
                          enabled: isReadOnly,
                        ),
                      ),
                    ),
                    IconTheme(
                      data: IconThemeData(color: Colors.blue.shade700),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
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
                            fullNameController.text.trim(),
                            emailController.text.trim());
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
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'By continuing, you agree to our ',
                //         ),
                //         GestureDetector(
                //           onTap: () {},
                //           child: Text(
                //             'Privacy Policy ',
                //             style: TextStyle(
                //               color: Colors.orange.shade700,
                //               decoration: TextDecoration.underline,
                //               fontSize: 14,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'and ',
                //         ),
                //         GestureDetector(
                //           onTap: () {},
                //           child: Text(
                //             'terms of service.',
                //             style: TextStyle(
                //               color: Colors.orange.shade700,
                //               decoration: TextDecoration.underline,
                //               fontSize: 14,
                //             ),
                //           ),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, List<String>> speacialities = {
  'Front End developer': ['Flutter', 'CSS', 'HTML'],
  'Back End developer': ['Java', 'Python', 'JavaScript'],
  'Designer': ['Figma', 'Adobe XD'],
  'QA': ['Quality Assurance'],
  'Database Engineer': ['Mysql', 'MongoDB']
};
