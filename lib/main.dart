import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_management/blok/authblock.dart';
import 'package:team_management/globals.dart';
import 'package:team_management/nav/bottomnavigationbar.dart';
import 'package:team_management/nav/developers_nav.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/theme/themechanger.dart';
import 'package:team_management/theme/themedata.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> roleCheck() async {
    try {
      QuerySnapshot<Map<String, dynamic>>  snap = await FirebaseFirestore
          .instance
          .collection('userData')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      dynamic data = snap.docs.first.data();
      role = data['roles'];
      print(role);
    } catch (e) {
      print('role issue');
    }
  }

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
          title: 'Team Management',
          theme: ThemeDataRepository.lightTheme,
          darkTheme: ThemeDataRepository.darkTheme,
          themeMode: themeChanger.themeMode,
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<void>(
            future: roleCheck(),
            builder: (context, snapshot) {
              if (FirebaseAuth.instance.currentUser != null) {
                if (role == 'Manager') {
                  return const BottomNavigation();
                } else {
                  return const DevelopersNav();
                }
              } else {
                return const Login();
              }
            },
          ),
        );
      }),
    );
  }
}
