import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';
import 'package:popover/popover.dart';

AppBar QuizNavBar(BuildContext context, String title, IconData icon) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.0,
    toolbarHeight: 75,
    flexibleSpace: Container(
      decoration: colorBackground1(context),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: () {
          // Handle the action when the icon is pressed
          showInfoPopup(
            context,
            'Selamat datang di Bahagian Kuiz Tajweed kami! Di sini, uji pengetahuan Tajweed anda secara menyeronokkan dan interaktif. 🌈📚 Kuiz khas ini akan menilai pemahaman hukum-hukum Tajweed. Bergabunglah untuk mengasah kemahiran membaca al-Quran dengan lebih baik dan terus memperkukuhkan kefahaman. Mari bersama-sama uji pengetahuan kita dengan riang dan semangat! 🚀🌟',
          );
        },
      ),
    ],
  );
}

void showInfoPopup(BuildContext context, String infoText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Text(
              infoText,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}



