import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';

class TextBox extends StatelessWidget {

  final String text;
  final String sectionName;
  void Function()? onPressed;
  TextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hexStringToColor("03045E"),
          width: 3, // You can change the border width here
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
      padding: EdgeInsets.only(bottom: 15),
      //margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    sectionName,
                  style: TextStyle(
                    color: hexStringToColor("03045E"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                        Icons.settings,
                      color: hexStringToColor("03045E"),
                    )
                )
              ],
            ),
          ),
          Divider(color: hexStringToColor("03045E"), thickness: 2,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
                text,
              style: TextStyle(
                  color: hexStringToColor("03045E"),
                  fontSize: 15
              )
            ),
          )
        ],
      ),
    );
  }
}
