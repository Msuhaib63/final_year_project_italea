import 'package:flutter/material.dart';
import '../../../Module/Quran/BookMarkModel.dart';
import '../../../Module/Quran/Surah.dart';
import '../../../Service/api_service.dart';
import '../../../Widget/Belajar_Widget/Search_field.dart';
import '../../../Widget/Quran_Widget/CustomTIle/Surah_customtile.dart';
import '../DetailScreen.dart';
import '../SurahPage.dart';

class SurahTab extends StatefulWidget {
  const SurahTab({super.key});

  @override
  State<SurahTab> createState() => _SurahTabState();
}

class _SurahTabState extends State<SurahTab> {
  final ApiService _apiService = ApiService();
  BookmarkModel bookmarkModel = initializeBookmarkModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Surah>>(
            future: _apiService.getSurahList(),
            builder: (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
              if(snapshot.hasData){
                List<Surah>? surah = snapshot.data;

                return ListView.builder(
                  itemCount: surah?.length ?? 0,
                    itemBuilder: (context, index) => SurahCustomListTile(
                      surah: surah![index],
                      context: context,
                      ontap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SurahPage(
                              surahList: surah,
                              initialBookmarkIndex: index,
                              initialPageNumber: null,
                            ),
                          ),
                        );
                      },
                    )
                );
              }
              return Center(child: CircularProgressIndicator());
            }
        ),
      ),
    );
  }
}
