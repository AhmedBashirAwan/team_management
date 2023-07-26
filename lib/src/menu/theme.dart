import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_management/src/menu/settings.dart';
import 'package:team_management/theme/themechanger.dart';

import '../../customised/widgets/bottomnavigation.dart';

class ThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 40),
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
          RadioListTile<ThemeMode>(
            title: Text(
              'Light Mode',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            value: ThemeMode.light,
            groupValue: themeChanger.themeMode,
            onChanged: (newThemeMode) => themeChanger.setTheme(newThemeMode!),
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              'Dark Mode',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            value: ThemeMode.dark,
            groupValue: themeChanger.themeMode,
            onChanged: (newThemeMode) => themeChanger.setTheme(newThemeMode!),
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              'System',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            value: ThemeMode.system,
            groupValue: themeChanger.themeMode,
            onChanged: (newThemeMode) => themeChanger.setTheme(newThemeMode!),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
