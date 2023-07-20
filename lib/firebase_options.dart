// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDsZ520eSf6FAwHBlu6EiiqhgT16Bf-dpg',
    appId: '1:557782554371:web:d1a2aeaa9794fefb1d7b36',
    messagingSenderId: '557782554371',
    projectId: 'project-management-two',
    authDomain: 'project-management-two.firebaseapp.com',
    storageBucket: 'project-management-two.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7Zfd7ZR8kOw7JD7-fVLeDWNHS4B0M8-A',
    appId: '1:557782554371:android:8a10fe0e9c185e081d7b36',
    messagingSenderId: '557782554371',
    projectId: 'project-management-two',
    storageBucket: 'project-management-two.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDsUu93NTbCNjEHHgU0t13J8AqhF8XZDM',
    appId: '1:557782554371:ios:2e749b894d11e11a1d7b36',
    messagingSenderId: '557782554371',
    projectId: 'project-management-two',
    storageBucket: 'project-management-two.appspot.com',
    iosClientId: '557782554371-kqkfebjg3k8jdehr9798uvpqcvgoo9gh.apps.googleusercontent.com',
    iosBundleId: 'com.example.teamManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDsUu93NTbCNjEHHgU0t13J8AqhF8XZDM',
    appId: '1:557782554371:ios:6ff444e49b9cbdf41d7b36',
    messagingSenderId: '557782554371',
    projectId: 'project-management-two',
    storageBucket: 'project-management-two.appspot.com',
    iosClientId: '557782554371-kssiqno3kp9tpdhnhl4vs6h9preep710.apps.googleusercontent.com',
    iosBundleId: 'com.example.teamManagement.RunnerTests',
  );
}