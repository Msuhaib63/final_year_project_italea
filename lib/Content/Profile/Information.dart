import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Widget/SecNavBar.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TopBar
                SecNavBar(title: "Information"),
                const SizedBox(height: 15),

                Center(
                  child: Text("Buku Rujukan", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                ),
                Card(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                        child: Image.asset(
                          "assets/icons/1.jpg",
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          children: [
                            Text("TAJWID AL-QUR'AN RASM 'UTHMANI"),
                            Text("Penulis:"),
                            Text("Pengenalan"),
                            Text("Buku yang diberi nama \"Tajwid Al-Quran Rasm Uthmani\" ini memberi maklumat kepada masyarakat Islam seluruhnya mengenai hukum-hukum tajwid dan penggunaan tanda-tanda bacaan Al-Quran Rasm Uthmani dalam bacaan ayat suci Al-Quran menurut Tariq Syatibi dari Riwayat Hafs bin Sulaiman ibn Al-Mughirah Al-Asadi Al-Kufi bagi Qiraat Asim bin Abi An-Najud Al-Kufi At-Tabi'i")
                          ],
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
