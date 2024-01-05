import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Text(
        "My name is Suhaib",
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }
}
