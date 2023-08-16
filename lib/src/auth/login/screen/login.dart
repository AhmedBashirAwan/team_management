import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/createaccount/screen/createaccount.dart';
import 'package:team_management/src/auth/forgetpassword/forgetpassword.dart';
import 'package:team_management/src/auth/register/register.dart';
import '../../../../customised/widgets/attachaccountbuttons.dart';
import '../../../../customised/widgets/buttons.dart';
import '../../../../globals.dart';
import '../../../Dashboard/screen/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          builder: (context) => const Registeration(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back,',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Text(
                'We want to see you here again. Enter your email number And password',
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
                      controller: _emailController,
                      onSubmitted: (value) {},
                      style: Theme.of(context).textTheme.titleSmall,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
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
                      controller: _passwordController,
                      onSubmitted: (value) {},
                      style: Theme.of(context).textTheme.titleSmall,

                      cursorColor: Colors.blue,
                      obscureText:
                          !_passwordVisible, // Toggle password visibility
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
                          _passwordVisible = !_passwordVisible;
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtons(
              buttonText: "Login",
              onPressed: () async {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                USER_ID = userCredential.user!.uid;
                print(USER_ID);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
            ),
            Divider(
              height: getHeight(context) * 0.03,
              color: Colors.grey.shade700,
              thickness: 1,
            ),
            Links(
              buttonText: 'Continue With Apple',
              icon: const Icon(Icons.apple),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              onPressed: () {},
            ),
            Links(
              buttonText: 'facebook',
              icon: const Icon(Icons.facebook),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {},
            ),
            Links(
              buttonText: 'google',
              icon: const Icon(Icons.report_gmailerrorred_outlined),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New User? ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccount(),
                        ),
                      );
                    },
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
