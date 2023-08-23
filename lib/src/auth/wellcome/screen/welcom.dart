import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/src/auth/register/register.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Timer _timer;
  int _seconds = 0;
  int _currentImageIndex = 0;
  int _currentTextIndex = 0;
  int _currentText2Index = 0;
  final List<String> _imagePaths = [
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image1.png',
  ];
  final List<String> _text = [
    'Focus On the Work That',
    'Stay Organized and',
    'Plan, manage and',
  ];
  final List<String> _text2 = [
    'matters',
    'efficient',
    'track Task',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        _seconds++;

        if (_seconds % 3 == 0) {
          _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
          _currentTextIndex = (_currentTextIndex + 1) % _text.length;
          _currentText2Index = (_currentText2Index + 1) % _text2.length;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: getHeight(context) * 0.65,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 174, 89, 0.80),
            Color.fromRGBO(255, 255, 255, 0.80),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            children: [
              Image.asset(_imagePaths[_currentImageIndex]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  _text[_currentTextIndex],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _text2[_currentText2Index],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: 25,
              color: _currentImageIndex == 0 ? Colors.black : Colors.black12,
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              height: 4,
              width: 25,
              color: _currentImageIndex == 1 ? Colors.black : Colors.black12,
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              height: 4,
              width: 25,
              color: _currentImageIndex == 2 ? Colors.black : Colors.black12,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'We will give you the easiest way to manage your day to day activities',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF272525),
                  foregroundColor: Colors.white,
                  minimumSize: Size(getwidth(context), 55),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started  ',
                      style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
