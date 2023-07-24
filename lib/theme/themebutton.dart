import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_management/theme/themechanger.dart';

class ThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: Text('Light Mode'),
            value: ThemeMode.light,
            groupValue: themeChanger.themeMode,
            onChanged: (newThemeMode) => themeChanger.setTheme(newThemeMode!),
          ),
          RadioListTile<ThemeMode>(
            title: Text('Dark Mode'),
            value: ThemeMode.dark,
            groupValue: themeChanger.themeMode,
            onChanged: (newThemeMode) => themeChanger.setTheme(newThemeMode!),
          ),
          RadioListTile<ThemeMode>(
            title: Text('System'),
            value: ThemeMode.system,
            groupValue: themeChanger.themeMode,
            onChanged: (newThemeMode) => themeChanger.setTheme(newThemeMode!),
          ),
        ],
      ),
    );
  }
}
