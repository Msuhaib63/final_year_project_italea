import 'dart:io';
import 'package:flutter/material.dart';

import '../../../Constant/color.dart';
import '../../../Content/Belajar/Pdf_viewer.dart';
import '../../../Service/pdf_service.dart';
import '../Button_pdf.dart';

class Description extends StatefulWidget {

  final String pdf1;
  final String pdf2;
  const Description({
    Key? key,
    required this.pdf1,
    required this.pdf2,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late File? pdfFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "Kami ada menyediakan bahan bacaan untuk lebih memahami tentang tajuk pelajaran yang telah di sampaikan",
              style: TextStyle(
                fontSize: 20,
                color: hexStringToColor("03045E"),
              ),
            ),
            /*ButtonWidget(
              text: 'Asset PDF',
              onClicked: () async {
                final path = 'assets/pdf/quran_tajwid.pdf';
                final file = await PDFApi.loadAsset(path);
                openPDF(context, file);
              },
            ),*/
            const SizedBox(height: 16),
            ButtonWidget(
              text: 'Nota Ringkas',
              onClicked: () async {
                final url = widget.pdf1;
                final file = await PDFApi.loadNetwork(url);
                openPDF(context, file);
              },
            ),
            ButtonWidget(
                text: "Nota Tambahan",
              onClicked: () async {
                final url = widget.pdf2;
                final file = await PDFApi.loadNetwork(url);
                openPDF(context, file);
              },
            )
            /*ButtonWidget(
              text: 'Firebase PDF',
              onClicked: () async {
                final url = 'quran_tajwid.pdf';
                final file = await PDFApi.loadFirebase(url);

                if (file == null) return;
                openPDF(context, file);
              },
            ),*/
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}