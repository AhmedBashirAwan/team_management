import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/auth/login/screen/login.dart';

class Confirmed extends StatefulWidget {
  const Confirmed({super.key});

  @override
  State<Confirmed> createState() => _ConfirmedState();
}

class _ConfirmedState extends State<Confirmed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded))
              ],
            ),
            Image.asset('assets/images/verification.png'),
            Text(
              'Great Your Password',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'has been changed',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Don\'t Worry. We will let you know if there is a ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              ' problem with your account. ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Spacer(),
            CustomButtons(
              buttonText: 'Back to Login',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
