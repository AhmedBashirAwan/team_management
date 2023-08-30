import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF272525),
        title: Text('Notifications'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 10, top: 10, bottom: 6, left: 10),
            child: Container(
              width: getwidth(context) * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.0,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
    );
  }
}
