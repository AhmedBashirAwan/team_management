import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';

class Links extends StatelessWidget {
  final String buttonText;
  final Icon icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final void Function()? onPressed;

  const Links({
    Key? key,
    required this.buttonText,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: getHeight(context) * 0.065,
        width: getwidth(context),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Text(
                buttonText,
                style: const TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
