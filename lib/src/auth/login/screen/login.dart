import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/main.dart';
import 'package:team_management/nav/bottomnavigationbar.dart';
import 'package:team_management/nav/developers_nav.dart';
import 'package:team_management/src/auth/createaccount/screen/createaccount.dart';
import 'package:team_management/src/auth/forgetpassword/forgetpassword.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/auth/wellcome/screen/welcom.dart';
import '../../../../customised/widgets/attachaccountbuttons.dart';
import '../../../../globals.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String role = '';
  Future<void> roleCheck() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('userData')
          .where('userId', isEqualTo: USER_ID)
          .get();

      dynamic data = snap.docs.first.data();
      role = data['roles'];
      print(role);
    } catch (e) {
      print('role issue');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
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
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 12),
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
                          controller: _emailController,
                          onSubmitted: (value) {},
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
                        data: const IconThemeData(color: Colors.grey),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle_outline_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.01,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 12),
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
                          controller: _passwordController,
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
                        data: const IconThemeData(color: Colors.grey),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(_passwordVisible
                              ? Icons.lock_outline
                              : Icons.lock),
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
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF92BB64),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      UserCredential userCredential =await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());
                      USER_ID = userCredential.user!.uid;
                      await roleCheck();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          if (role == 'Manager') {
                            return const BottomNavigation();
                          } else {
                            return const DevelopersNav();
                          }
                        },
                      ), (route) => false);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) {
                      //     if (role == 'Manager') {
                      //       return const BottomNavigation();
                      //     } else {
                      //       return const DevelopersNav();
                      //     }
                      //   }),
                      // );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Authentication failed. Please check your credentials.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF92BB64),
                    foregroundColor: Colors.white,
                    minimumSize: Size(getwidth(context), 50),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  ),
                ),
                Divider(
                  height: getHeight(context) * 0.03,
                  color: Colors.grey.shade400,
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
                  padding: const EdgeInsets.only(top: 30),
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
                        child: const Text(
                          'Create an Account',
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
        ));
  }
}
