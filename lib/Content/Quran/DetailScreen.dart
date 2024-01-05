import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_year_project_italea/Constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Constant/color.dart';
import '../../Module/Quran/Ayat.dart';
import '../../Module/Quran/Surah.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurat");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
        future: _getDetailSurah(),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
            );
          }
          Surah surah = snapshot.data!;
          return Scaffold(
            backgroundColor: background,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _details(surah: surah, context: context),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) => _ayatItem(
                      ayat: surah.ayat!
                          .elementAt(index + (noSurat == 1 ? 1 : 0))),
                  itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                  separatorBuilder: (context, index) => Container(),
                ),
              ),
            ),
          );
        }));
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                    color: hexStringToColor('A44AFF'),
                    borderRadius: BorderRadius.circular(27 / 2)),
                child: Center(
                    child: Text(
                      '${ayat.nomor}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
              const Spacer(),
              const Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.play_arrow_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.bookmark_outline,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          ayat.ar,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          ayat.tr,
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 13),
          textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          ayat.idn,
          style: TextStyle(color: hexStringToColor('A19CC5'), fontSize: 16),
        )
      ],
    ),
  );

  Widget _details({required Surah surah, required BuildContext context}) => Padding(
    padding: const EdgeInsets.only(right: 24, left: 24, top: 20),
    child: GestureDetector(
      onTap: () => Get.defaultDialog(
        title: "Tafsir",
        middleText: "${_replaceHtmlTags(surah.deskripsi)}",
      ),
      child: Stack(children: [
        Container(
          height: 257,
          decoration: colorBackground(context),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
                opacity: .2,
                child: SvgPicture.asset(
                  imQuran,
                  width: 324 - 55,
                ))),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Text(
                surah.namaLatin,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 26),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                surah.arti,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              Divider(
                color: Colors.white.withOpacity(.35),
                thickness: 2,
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    surah.tempatTurun.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${surah.jumlahAyat} Ayat",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SvgPicture.asset(imBismillah)
            ],
          ),
        )
      ]),
    ),
  );

  String _replaceHtmlTags(String htmlString) {
    // Replace <i> with "" and remove </i>
    String processedString = htmlString.replaceAll(RegExp(r'<i>'), '').replaceAll(RegExp(r'</i>'), '');

    // Replace <br> with a line break
    processedString = processedString.replaceAll(RegExp(r'<br\s*/?>'), '\n');

    // Replace <i>text</i> with italicized text
    processedString = processedString.replaceAllMapped(
      RegExp(r'<i>(.*?)<\/i>'),
          (match) => '*${match.group(1)}*', // Use Markdown-style italicization with asterisks
    );

    return processedString;
  }

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
              onPressed: (() => Navigator.of(context).pop()),
              icon: Icon(Icons.arrow_back),color: Colors.white,),
          const SizedBox(
            width: 24,
          ),
          Text(
            surah.namaLatin,
            style:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          const Spacer(),
          IconButton(
              onPressed: (() => {}),
              icon: Icon(Icons.search), color: Colors.white,),
        ]),
      );
}