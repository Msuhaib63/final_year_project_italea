import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';
import 'package:popover/popover.dart';

AppBar QuranNavBar(BuildContext context, String title, IconData icon) {
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
            '📖🌟Al-Quran Berwarna Tajweed📖🌟\n\n🌈 Baca dengan mudah dan pahami hukum tajweed melalui kod warna pada setiap muka surat.\n\n🚀 Akses Juz Mudah 🚀:\n🔍 Temukan ayat dengan cepat - akses al-Quran mengikut juz untuk membaca dengan lebih teratur.\n\n🎶 Dengar Qari Pilihan 🎶\n👂 Dengarkan bacaan al-Quran dari Qari pilihan anda, hadirkan keindahan suara ke dalam pengalaman membaca anda.\n\n📍 Simpan Penanda Buka 📍:\n📌 Simpan ayat-ayat istimewa anda untuk mudah rujuk dan kembali.',
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
