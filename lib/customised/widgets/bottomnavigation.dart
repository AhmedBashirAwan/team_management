import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_management/src/auth/register/register.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) * 0.08,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 35,
              icon: Icon(
                Icons.window_rounded,
              ),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 35,
              icon: Icon(
                Icons.verified_outlined,
              ),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue, //<-- SEE HERE
              child: IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 35,
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.grey.shade700,
              highlightColor: Colors.blue.shade100,
              iconSize: 30,
              icon: Icon(
                Icons.messenger_outline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
