import 'dart:developer';
import 'package:flutter/material.dart';

class AppBlok extends ChangeNotifier {
  AppBlok() {
    log("AppBlok is working...");
  }
  int _activeIndex = 1;
  List<Widget> _screens = [];

  switchScreen(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  Widget getActiveScreen() {
    return _screens[_activeIndex];
  }
}
