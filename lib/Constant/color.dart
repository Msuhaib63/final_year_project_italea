import 'package:flutter/material.dart';

hexStringToColor(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll(("#"), (""));
  if(hexColor.length == 6){
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

//for Quiz
Color correct = hexStringToColor('32AB58');
Color incorrect = hexStringToColor('AB3232');
Color neutral = hexStringToColor('E7E7E7');
Color background = hexStringToColor('1A3464');

//all background
BoxDecoration colorBackground(BuildContext context) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          hexStringToColor("03045E"),
          hexStringToColor("0077B6"),
          hexStringToColor("00B4D8"),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )
  );
}
BoxDecoration colorBackground1(BuildContext context) {
  return BoxDecoration(

      gradient: LinearGradient(
        colors: [
          hexStringToColor("03045E"),
          hexStringToColor("0077B6"),
          hexStringToColor("00B4D8"),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )
  );
}
BoxDecoration colorBackground2(BuildContext context) {
  return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          hexStringToColor("03045E"),
          hexStringToColor("0077B6"),
          hexStringToColor("00B4D8"),
        ],
        begin: const FractionalOffset(0.0, 0.4),
        end: Alignment.topRight,
      )
  );
}
BoxDecoration colorBackground3(BuildContext context) {
  return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          hexStringToColor("00B4D8"),
          hexStringToColor("0077B6"),
          hexStringToColor("03045E"),
        ],
        begin: const FractionalOffset(0.0, 0.4),
        end: Alignment.topRight,
      )
  );
}
BoxDecoration colorBackground4(BuildContext context) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [
          hexStringToColor("0077B6"),
          hexStringToColor("03045E"),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      )
  );
}
BoxDecoration colorBackground5(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4,0.8],
      colors: [
        hexStringToColor("00B4D8"),
        hexStringToColor("0077B6"),
        hexStringToColor("03045E"),
      ],
    ),
  );
}

BoxDecoration colorBackground6(BuildContext context) {
  return BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      gradient: LinearGradient(
        colors: [
          hexStringToColor("03045E"),
          hexStringToColor("0077B6"),
          hexStringToColor("00B4D8"),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )
  );
}
BoxDecoration colorBackground7(BuildContext context) {
  return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          hexStringToColor("03045E"),
          hexStringToColor("0077B6"),
          hexStringToColor("00B4D8"),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )
  );
}
BoxDecoration colorBackground8(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.1, 0.4,0.8],
      colors: [
        hexStringToColor("03045E"),
        hexStringToColor("0077B6"),
        hexStringToColor("00B4D8"),
      ],
    ),
  );
}
BoxDecoration colorBackground9(BuildContext context) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          hexStringToColor("03045E"),
          hexStringToColor("0077B6"),
          hexStringToColor("00B4D8"),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )
  );
}