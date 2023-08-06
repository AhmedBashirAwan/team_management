import 'package:flutter/material.dart';
import 'package:team_management/src/auth/login/screen/login.dart';

import '../../../customised/widgets/attachaccountbuttons.dart';

class Registeration extends StatefulWidget {
  const Registeration({super.key});

  @override
  State<Registeration> createState() => RregisterationState();
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getwidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class RregisterationState extends State<Registeration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/register.png')),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Stay Organized With team',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'We will give you the easiest way to manage your day to day activities',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
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
                  Links(
                    buttonText: 'Email',
                    icon: const Icon(Icons.email),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: Text(
                              'Login ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                              'By continuing, you agree to our',
                              style: Theme.of(context).textTheme.titleSmall,
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
                              style: Theme.of(context).textTheme.titleSmall,
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
          ],
        ),
      ),
    );
  }
}
