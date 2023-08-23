import 'package:flutter/cupertino.dart';
import 'package:team_management/src/auth/createaccount/screen/createaccount.dart';
import 'package:team_management/src/auth/login/screen/login.dart';
import 'package:team_management/src/auth/wellcome/screen/welcom.dart';

class AuthBlok extends ChangeNotifier {
  int _activeIndex = 1;
  final List<Widget> _screens = [
    const WelcomeScreen(),
    const Login(),
    const CreateAccount(),
  ];

  switchScreen(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  Widget getActiveScreen() {
    return _screens[_activeIndex];
  }
}
