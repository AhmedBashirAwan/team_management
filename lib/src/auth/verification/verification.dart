import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/auth/createaccount/screen/createaccount.dart';
import 'package:team_management/src/auth/verification/components/confirmed.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                          builder: (context) => const CreateAccount(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            Row(
              children: [
                Text(
                  'Email Verification',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'We have send you the code to your given address.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // OtpTextField(
                  //   numberOfFields: 4,
                  //   borderColor: const Color.fromARGB(255, 8, 8, 8),
                  //   showFieldAsBox: true,
                  //   onSubmit: (String verificationCode) async {
                  //     otp.text = verificationCode;
                  //   },
                  // ),
                ],
              ),
            ),
            const Spacer(),
            CustomButtons(
              buttonText: 'Verify Account',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Confirmed(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
