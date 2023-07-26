import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/menu/settings.dart';

import '../../customised/widgets/bottomnavigation.dart';

class Generals extends StatefulWidget {
  const Generals({Key? key}) : super(key: key);

  @override
  State<Generals> createState() => _GeneralsState();
}

class _GeneralsState extends State<Generals> {
  bool isChecked1 = false;
  bool isChecked2 = false;

  void _handleCheckbox1ValueChanged(bool? value) {
    setState(() {
      isChecked1 = value ?? false;
    });
  }

  void _handleCheckbox2ValueChanged(bool? value) {
    setState(() {
      isChecked2 = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define your getHeight function here or use MediaQuery to get screen dimensions.

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => settings(),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_back)),
                Text(
                  'Generals',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: getHeight(context) * 0.06,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Language',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'Set Automatically',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smart date recognition',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'Automatically detect due to date in task',
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isChecked1,
                            onChanged: _handleCheckbox1ValueChanged,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Another Checkbox',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'Set Another Checkbox',
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Checkbox(
                            value: isChecked2,
                            onChanged: _handleCheckbox2ValueChanged,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date & Time',
                            style: TextStyle(
                                color: Colors.amber.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.09,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time Zone',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'The App and email remainders will use ',
                          ),
                          Text('asia / colombo')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.015,
                ),
                SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start the Week on',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'Monday',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.015,
                ),
                SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Interpret "Next week" as',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'Monday',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.015,
                ),
                SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Interpret "Next weekend" as',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          Text(
                            'Sunday',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.015,
                ),
              ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
