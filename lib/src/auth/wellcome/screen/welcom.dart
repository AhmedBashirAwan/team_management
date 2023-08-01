import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/createaccount/screen/createaccount.dart';
import 'package:team_management/src/auth/register/register.dart';
import '../../../../customised/widgets/buttons.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          child: Column(children: [
            Image.asset('assets/images/onboard-light.png'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Manage your team & everthing with us',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'We will give you the easiest way to manage your day to day activities',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context) * 0.014,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomButtons(
                        buttonText: 'Sign In',
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccount(),
                            ),
                          );
                        },
                      )),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
