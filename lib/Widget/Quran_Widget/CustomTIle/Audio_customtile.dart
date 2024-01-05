import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/color.dart';

Widget AudioTile({
  required String? surahName,
  required totalAyah,
  required number,
  required VoidCallback onTap
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  color: Colors.black12,
                  offset: Offset(0,3)
              )
            ]
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 50,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: hexStringToColor("03045E"),
              ),
              child: Text(
                (number).toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surahName!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: hexStringToColor("03045E"),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 3),
                Text("Total Ayah : $totalAyah", style:  TextStyle(color: hexStringToColor("03045E"), fontSize: 16),)
              ],
            ),
            Spacer(),
            Icon(Icons.play_circle_fill, color: hexStringToColor('03045E'),)
          ],
        ),
      ),
    ),
  );
}