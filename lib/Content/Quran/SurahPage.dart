import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_italea/Constant/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Module/Quran/BookMarkModel.dart';
import '../../Constant/color.dart';
import '../../Module/Quran/Surah.dart';

class SurahPage extends StatefulWidget {
  final List<Surah>? surahList;
  final int? initialBookmarkIndex;
  final int? initialPageNumber;

  const SurahPage({
    Key? key,
    required this.surahList,
    required this.initialBookmarkIndex,
    required this.initialPageNumber
  }) : super(key: key);

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  late SharedPreferences _preferences;
  List<int> bookmarks = [];


  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();

    if (widget.initialBookmarkIndex != null && widget.initialPageNumber == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        int targetPageNumber = widget.surahList![widget.initialBookmarkIndex!].ms;
        _pdfViewerController.jumpToPage(targetPageNumber);
      });
    } else if (widget.initialBookmarkIndex == null && widget.initialPageNumber != null) {
      _pdfViewerController.jumpToPage(widget.initialPageNumber ?? 0);
    }
  }

  @override
  void dispose() {
    _saveLastRead();
    super.dispose();
  }

  void _saveLastRead() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('lastReadSurah', widget.surahList![0].nama); // Assuming you have a surahList
    preferences.setInt('lastReadAyat', _pdfViewerController.pageNumber);
    // Add other relevant information
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: colorBackground1(context)
          ),
          title: Text(
            "Quran Tajweed",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          toolbarHeight: 75,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _pdfViewerController.zoomLevel = 1.20;
              },
              icon: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                _showBookmarkSavedSnackbar();
              },
              icon: Icon(
                bookmarks.contains(_pdfViewerController.pageNumber)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: Colors.white,
              ),
            ),
          ],

        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 130,
              child: SfPdfViewer.asset(
                "assets/pdf/quran_tajwid.pdf",
                controller: _pdfViewerController,
                key: _pdfViewerStateKey,
                pageLayoutMode: PdfPageLayoutMode.single,
                scrollDirection: PdfScrollDirection.horizontal,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                picBotQuran,
                height: 120,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookmarkSavedSnackbar() async {
    int pageNumber = _pdfViewerController.pageNumber;
    final currentUser = FirebaseAuth.instance.currentUser!;
    User? user = currentUser;

    // Check if the page number is already bookmarked for the current user
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .collection('bookmarks')
        .where('page_number', isEqualTo: pageNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Page is already bookmarked, remove bookmark and update UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Page $pageNumber is already bookmarked.'),
        ),
      );
      return;
    }

    if (user != null) {
      // Save bookmark to Firebase
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.uid).collection('bookmarks')
          .add({
        'page_number': pageNumber,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    setState(() {
      bookmarks.add(pageNumber);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bookmark saved at page $pageNumber'),
      ),
    );
  }
}


