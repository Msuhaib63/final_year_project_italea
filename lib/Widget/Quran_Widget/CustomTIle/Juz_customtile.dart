import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Constant/color.dart';
import '../../../Module/Quran/Juz.dart';

class JuzCustomTile extends StatelessWidget {
  final List<JuzAyahs> list;
  final int index;

  JuzCustomTile({
    required this.list,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                        child: Text(
                          list[index].ayahNumber.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        )),
                  ),
                  const SizedBox(width: 20,),
                  Text(
                      list[index].surahName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              list[index].ayahsText,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}