import 'package:flutter/material.dart';
import 'package:team_management/src/menu/settings.dart';
import '../../customised/widgets/bottomnavigation.dart';
import '../auth/register/register.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isChecked1 = false;
  void _handleCheckbox1ValueChanged(bool? value) {
    setState(() {
      isChecked1 = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const settings(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context) * 0.07,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Local Notifications',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          const Text(
                            'Sent push notifications to this device',
                          ),
                        ],
                      ),
                      const Spacer(),
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
                SizedBox(
                  height: getHeight(context) * 0.015,
                ),
                SizedBox(
                  height: getHeight(context) * 0.06,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Review',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          const Text(
                            'get a daily summary of your tasks',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 15,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context) * 0.008,
                ),
                SizedBox(
                  height: getHeight(context) * 0.09,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sharing',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          const Text(
                            'Get Notified about updates  ',
                          ),
                          const Text('Shared Projects')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.008,
                ),
                SizedBox(
                  height: getHeight(context) * 0.09,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subscribed Emails',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.008,
                          ),
                          const Text(
                            'Choose which Emails will you like ',
                          ),
                          const Text('to recieve')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
