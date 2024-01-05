import 'package:final_year_project_italea/Module/Quran/Surah.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constant/color.dart';
import '../../../Module/Quran/Surah.dart';

Widget SurahCustomListTile({
  required Surah surah,
  required BuildContext context,
  required void Function() ontap,
}) {
  return GestureDetector(
    onTap: () => ontap(),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0
            )
          ]
      ),
      child: Column(
        children: [
          Row(
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
                child: Text((surah.nomor).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.namaLatin!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: hexStringToColor("03045E"),), ),
                  Row(
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: TextStyle(
                            color: hexStringToColor('A19CC5'),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: hexStringToColor('A19CC5')),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: TextStyle(
                            color: hexStringToColor('A19CC5'),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  )                ],
              ),
              Spacer(),
              Text( ' سورة ${surah.nama!} ', style: TextStyle(color: hexStringToColor("03045E"),
              fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          )
        ],
      ),
    ),
  );
}