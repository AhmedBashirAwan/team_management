import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_management/blok/appblock.dart';
import 'package:team_management/src/auth/wellcome/screen/welcom.dart';
import 'package:team_management/theme/themechanger.dart';
import 'package:team_management/theme/themedata.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
        ChangeNotifierProvider(create: (_) => AppBlok()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          title: 'Flutter Theming Tutorials',
          theme: ThemeDataRepository.lightTheme,
          darkTheme: ThemeDataRepository.darkTheme,
          themeMode: themeChanger.themeMode,
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return WelcomeScreen();
              } else {
                return WelcomeScreen();
              }
            },
          ),
        );
      }),
    );
  }
}
