import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final String buttonText;
  final Icon? icon; // Make the Icon nullable by using Icon?
  final void Function()? onPressed; // New onPressed property

  const CustomButtons({
    Key? key,
    required this.buttonText,
    this.icon,
    this.onPressed, // Add onPressed to the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 400,
      child: ElevatedButton(
        onPressed: onPressed, // Use the provided onPressed function
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          backgroundColor: Colors.blue, // Button color
          foregroundColor: Colors.white, // Text color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(fontSize: 20.0),
            ),
            if (icon != null) // Conditionally include the icon if it's not null
              SizedBox(
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
