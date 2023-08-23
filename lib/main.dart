import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_management/blok/authblock.dart';
import 'package:team_management/src/dashboard/components/admindashboard.dart';
import 'package:team_management/src/dashboard/screen/dashboard.dart';
import 'package:team_management/src/projects/components.dart/adproject.dart';
import 'package:team_management/src/projects/components.dart/allprojects.dart';
import 'package:team_management/src/projects/components.dart/createproject.dart';
import 'package:team_management/theme/themechanger.dart';
import 'package:team_management/theme/themedata.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
        ChangeNotifierProvider(create: (_) => AuthBlok()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          title: 'Flutter Theming Tutorials',
          theme: ThemeDataRepository.lightTheme,
          darkTheme: ThemeDataRepository.darkTheme,
          themeMode: themeChanger.themeMode,
          debugShowCheckedModeBanner: false,
          //home: const AdminDashboard(),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const AdProject();
              } else {
                return const AdProject();
              }
            },
          ),
        );
      }),
    );
  }
}
