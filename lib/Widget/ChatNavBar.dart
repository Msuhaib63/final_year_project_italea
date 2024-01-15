import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';
import 'package:popover/popover.dart';

AppBar ChatNavBar(BuildContext context, String title, IconData icon) {
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
            '👋 Selamat datang di Chat Page kami! Nikmati komunikasi yang mudah dan tambah dimensi ke dalam perbualan:\n\n🎙️ Voice Record & 📸 Ambil Gambar:\nLuangkan idea atau perasaan anda dengan suara melalui "Voice Record" atau kongsi momen dengan gambar dari kamera atau galeri.\n\n🤲📞 Direct Contact ke Murabbi/Ustaz Tajweed:\nHubungi secara langsung Murabbi atau Ustaz bertauliah dalam Tajweed. Dapatkan nasihat atau jadualkan sesi pembelajaran segera!\n\nSertai kami sekarang untuk pengalaman komunikasi yang bermakna dan berkesan! 🌟',
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
