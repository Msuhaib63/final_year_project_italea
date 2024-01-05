import 'package:final_year_project_italea/Module/Quran/Qari.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Module/Quran/Surah.dart';
import '../../Service/api_service.dart';
import '../../Widget/Custom_backicon.dart';
import '../../Widget/Quran_Widget/CustomTIle/Audio_customtile.dart';
import 'AudioScreen.dart';



class AudioSurahScreen extends StatefulWidget {

  final Qari qari;

  const AudioSurahScreen({
    Key? key,
    required this.qari,
  }) : super(key: key);

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {

  final ApiService _apiService = ApiService();

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
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: Container(
                            width:250,
                            child: Text(
                              widget.qari.name!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: CustomIconButton(
                          child: const Icon(Icons.arrow_back),
                          height: 35,
                          width: 35,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                      child: FutureBuilder(
                        future: _apiService.getSurahList(),
                        builder: (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                          if (snapshot.hasData) {
                            List <Surah>? surah = snapshot.data;
                            return ListView.builder(
                                itemCount: surah!.length,
                                itemBuilder: (context, index) =>
                                    AudioTile(
                                        surahName: snapshot.data![index].namaLatin,
                                        totalAyah: snapshot.data![index].jumlahAyat,
                                        number: snapshot.data![index].nomor,
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder:
                                              (context) => AudioScreen(
                                              qari: widget.qari,
                                              index: index + 1,
                                              list: surah
                                          )
                                          )
                                          );
                                        }
                                    )
                            );
                          }
                          return Center(child: CircularProgressIndicator(),);
                        },
                      )
                  )


                ],
              ),
            ),
          ),
        )
    );
  }



}
