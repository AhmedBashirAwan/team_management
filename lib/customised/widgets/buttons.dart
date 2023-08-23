import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';

class CustomButtons extends StatelessWidget {
  final String buttonText;
  final Icon? icon;
  final void Function()? onPressed;

  const CustomButtons({
    Key? key,
    required this.buttonText,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: getwidth(context),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          backgroundColor: const Color(0xFF92BB64),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: const TextStyle(fontSize: 20.0),
            ),
            if (icon != null) // Conditionally include the icon if it's not null
              const SizedBox(
                width: 10,
              ),
            if (icon != null) // Conditionally include the icon if it's not null
              icon!,
          ],
        ),
      ),
    );
  }
}
