import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Constant/color.dart';
import '../../../Module/Quran/BookMarkModel.dart';
import '../SurahPage.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  Future<void> _deleteBookmark(String bookmarkId) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .collection('bookmarks')
        .doc(bookmarkId)
        .delete();

    // Refresh the UI, if necessary
    // setState(() {
    //   // Update local state
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).collection("bookmarks").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<QueryDocumentSnapshot> bookmarks = snapshot.data!.docs;
              if (bookmarks.isEmpty) {
                return Center(
                  child: Text('No bookmarks available.'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmarkData = bookmarks[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: hexStringToColor("03045E"),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Bookmark ${index + 1} - Muka Surat ${bookmarkData["page_number"]}',
                          style: TextStyle(
                            color: hexStringToColor("03045E"),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                          Icons.delete,
                        color: hexStringToColor("03045E"),
                      ),
                      onPressed: () {
                        _deleteBookmark(bookmarks[index].id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahPage(
                            surahList: null, // pass the appropriate list
                            initialBookmarkIndex: null, // pass the appropriate index
                            initialPageNumber: bookmarkData["page_number"], // pass the page_number
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 1,color: hexStringToColor("03045E"),indent: 10,endIndent: 10,),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
