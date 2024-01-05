import 'package:flutter/material.dart';

import '../../Constant/color.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      /*style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),*/
      child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: onClicked,
      style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return hexStringToColor("07BEB8");
            }
            return hexStringToColor("03045E");
          }
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              )
          )
      ),
    ),
  );
}