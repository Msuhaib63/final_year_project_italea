import 'package:flutter/material.dart';

import '../Constant/color.dart';
import 'Custom_backicon.dart';

class SecNavBar extends StatelessWidget {

  final String title;

  const SecNavBar({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Center(
            child: SizedBox(
              width:250,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: hexStringToColor("03045E")
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: CustomIconButton(
              child: Icon(Icons.arrow_back, color: hexStringToColor('A19CC5'),),
              height: 35,
              width: 35,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
    );
  }
}
