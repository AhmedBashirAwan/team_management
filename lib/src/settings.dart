import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // value: provider.currentTheme,
      items: [
        //Light, dark, and system
        DropdownMenuItem<String>(
          value: 'light',
          child: Text(
            'Light',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        DropdownMenuItem<String>(
          value: 'dark',
          child: Text(
            'Dark',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        DropdownMenuItem<String>(
          value: 'system',
          child: Text(
            'System',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
      onChanged: (String? value) {
        // provider.changeTheme(value ?? 'system');
      },
    );
  }
}
