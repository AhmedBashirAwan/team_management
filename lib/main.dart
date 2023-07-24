import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_management/src/auth/wellcome/screen/welcom.dart';
import 'package:team_management/theme/themechanger.dart';
import 'package:team_management/theme/themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeChanger())],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          title: 'Flutter Theming Tutorials',
          theme: ThemeDataRepository.lightTheme,
          darkTheme: ThemeDataRepository.darkTheme,
          themeMode: themeChanger.themeMode,
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen(),
        );
      }),
    );
  }
}
