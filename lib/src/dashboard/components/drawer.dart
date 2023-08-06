import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/src/menu/notifications.dart';
import 'package:team_management/src/menu/settings.dart';
import 'package:team_management/src/menu/theme.dart';

import '../../auth/register/register.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void _showRateAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Rate My App',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How would you rate this app?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Handle 1-star rating
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.star, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Handle 2-star rating
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.star, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Handle 3-star rating
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.star, color: Colors.yellow),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Handle 4-star rating
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.star, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Handle 5-star rating
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.star, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'We would love to hear your feedback',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // TODO: Add a text input for feedback
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // TODO: Handle "Submit" button
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Handle "Later" button
                Navigator.of(context).pop();
              },
              child: const Text('Later'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getHeight(context) * 0.1,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
          ),
          height: getHeight(context) * 0.1,
          width: getwidth(context) * 0.6,
          child: Row(
            children: [
              SizedBox(
                width: getwidth(context) * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getHeight(context) * 0.06,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          'https://i2-prod.gazettelive.co.uk/incoming/article20679579.ece/ALTERNATES/s615b/0_jwr_mga_260521willowgracecampbell.jpg'),
                    ),
                  )
                ],
              ),
              const VerticalDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Impact It Solutions',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      Text(
                        'Workspace',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const settings(),
                    ),
                  );
                },
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.settings),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  );
                },
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_active_outlined),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Notification',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_border_outlined),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Support',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => _showRateAppDialog(context),
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Rate the App',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.question_mark),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Whats new',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemeButton(),
                    ),
                  );
                },
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.wb_sunny_outlined),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Themes',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  } catch (e) {
                    print('Error signing out: $e');
                  }
                },
                child: SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      SizedBox(
                        width: getwidth(context) * 0.05,
                      ),
                      Text(
                        'Log Out',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
