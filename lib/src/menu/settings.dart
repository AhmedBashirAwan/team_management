import 'package:flutter/material.dart';
import 'package:team_management/src/menu/general.dart';
import 'package:team_management/src/menu/notifications.dart';
import 'package:team_management/src/menu/profile.dart';
import 'package:team_management/src/menu/theme.dart';

import '../../customised/widgets/bottomnavigation.dart';
import '../Dashboard/screen/dashboard.dart';
import '../auth/register/register.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: getHeight(context) * 0.07,
                      child: Row(
                        children: [
                          const Icon(Icons.person_2_outlined),
                          SizedBox(
                            width: getwidth(context) * 0.05,
                          ),
                          Text(
                            'Account',
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
                          builder: (context) => const Generals(),
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
                            'General',
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
                          const Icon(Icons.notification_important_outlined),
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
                          const Icon(Icons.favorite_border),
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
                            'Rate our App',
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
                          const Icon(Icons.crisis_alert_sharp),
                          SizedBox(
                            width: getwidth(context) * 0.05,
                          ),
                          Text(
                            'Whats New ',
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
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
