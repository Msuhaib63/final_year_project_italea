import 'package:final_year_project_italea/Widget/QuranNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/color.dart';
import '../Constant/icons.dart';

import '../Content/Quran/QuranTab/BookmarkPage.dart';
import '../Content/Quran/QuranTab/Juz_tab.dart';
import '../Content/Quran/QuranTab/Qari_tab.dart';
import '../Content/Quran/QuranTab/Surah_tab.dart';
import '../Content/Quran/SurahPage.dart';
import '../Module/Quran/BookMarkModel.dart';



class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}


class _QuranPageState extends State<QuranPage> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: QuranNavBar(context, "Quran Page", Icons.info),
        body: DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
               SliverToBoxAdapter(
                child: _lastRead(context),
              ),
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  shape: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: const Color(0xFFAAAAAA).withOpacity(.1)
                      )
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(5),
                    child: _tab(),
                  ),
                )
              ],
                body: TabBarView(
                    children: [SurahTab(), JuzTab(), QariTab(),BookmarkPage(),]
                )
              ),
            ),
          ),
        ),
      );
  }
}

// Function to create the TabBar
TabBar _tab() {
  return TabBar(
      unselectedLabelColor: hexStringToColor("A19CC5"),
      labelColor: hexStringToColor("03045E"),
      indicatorWeight: 4,
      tabs: [
        _tabItem(label: "Surah"),
        _tabItem(label: "Juz"),
        _tabItem(label: "Qari"),
        _tabItem(label: "Bookmark"),
      ]);
}

// Function to create individual Tab item
Tab _tabItem({required String label}) {
  return Tab(
    child: Text(
      label,
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
}

// Function to create the Last Read section
GestureDetector _lastRead(BuildContext context) {
  String lastReadSurah = '';
  int lastReadAyat = 0;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurahPage(
            surahList: null,
            initialBookmarkIndex: 0, // Calculate the index based on surah name,
            initialPageNumber: lastReadAyat,
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 131,
            decoration: colorBackground(context),
          ),
          Positioned(
              bottom: 10,
              right: 0,
              child: SvgPicture.asset(imQuran)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(imBook),
                    const SizedBox(width: 8,),
                    Text(
                      'Last Read',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Al-Fatihah',
                  style:  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ayat No: 1',
                  style:  TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
