import 'dart:convert';
import 'dart:math';
import 'dart:convert';
import 'package:final_year_project_italea/Module/Quran/Qari.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../Module/Quran/Ayat.dart';
import '../Module/Quran/AyatADay.dart';
import '../Module/Quran/Juz.dart';
import '../Module/Quran/Surah.dart';


class ApiService{

  final endPointUrl ="http://api.alquran.cloud/v1/surah";
  List<Surah> Surah2list = [];
  static int? juzIndex;
  List<Qari> Qarilist = [];
  static int? surahIndex;

  Future<AyahADay> getAyahADay() async {
    String url = "http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200){
      return AyahADay.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to Load Post");
    }
  }

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  /*Future<List<Surah>> getSurahList() async {
    final url = "https://equran.id/api/surat";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Surah> surahList = [];

      for (int index = 0; index < jsonData.length; index++) {
        final surahData = jsonData[index];
        if (surahData is Map<String, dynamic>) {
          surahList.add(Surah(
            nomor: index + 1,
            ms: index + 1,
            nama: surahData["nama"],
            namaLatin: surahData["nama_latin"],
            jumlahAyat: surahData["jumlah_ayat"],
            tempatTurun: surahData["tempat_turun"] == "mekah"
                ? TempatTurun.MEKAH
                : TempatTurun.MADINAH,
            arti: surahData["arti"],
            deskripsi: surahData["deskripsi"],
            audio: surahData["audio"],
            ayat: surahData.containsKey('ayat')
                ? List<Ayat>.from(surahData["ayat"].map((x) => Ayat.fromJson(x)))
                : null,
          ));
        }
      }

      print('Total Surahs: ${surahList.length}');
      return surahList;
    } else {
      throw ("Can't get the Surah");
    }
  }*/

  Future<List<Surah>> getSurahList() async {
    try {
      // Load the JSON data from the assets
      String jsonString = await rootBundle.loadString('assets/json/surah.json');

      // Decode the JSON data
      List<dynamic> jsonData = jsonDecode(jsonString);

      List<Surah> surahList = [];

      for (int index = 0; index < jsonData.length; index++) {
        final surahData = jsonData[index];
        if (surahData is Map<String, dynamic>) {
          surahList.add(Surah(
            nomor: index + 1,
            ms: surahData["ms"],
            nama: surahData["nama"],
            namaLatin: surahData["nama_latin"],
            jumlahAyat: surahData["jumlah_ayat"],
            tempatTurun: surahData["tempat_turun"] == "mekah"
                ? TempatTurun.MEKAH
                : TempatTurun.MADINAH,
            arti: surahData["arti"],
            deskripsi: surahData["deskripsi"],
            audio: surahData["audio"],
            ayat: surahData.containsKey('ayat')
                ? List<Ayat>.from(surahData["ayat"].map((x) => Ayat.fromJson(x)))
                : null,
          ));
        }
      }

      return surahList;
    } catch (e) {
      // Handle errors, e.g., if the file is not found or has incorrect format
      print("Error loading Surah data: $e");
      return [];
    }
  }

  /*Future<List<Surah>> getSurahList() async {
    String url = "https://equran.id/api/surat";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Surah> surahList = [];

      jsonData.forEach((element) {
        if (element is Map<String, dynamic>) {
          surahList.add(Surah.fromJson(element));
        }
      });

      print('Total Surahs: ${surahList.length}');
      return surahList;
    } else {
      throw ("Can't get the Surah");
    }
  }*/

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to Load Post");
    }
  }

  /*Future<SurahTranslationList> getTranslation(int index , int translationIndex) async{

    String lan = "";
    if(translationIndex == 0){
      lan = "urdu_junagarhi";
    }else if(translationIndex == 1){
      lan = "hindi_omari";
    }else if(translationIndex == 2){
      lan = "english_saheeh";
    }else if(translationIndex == 3){
      lan = "spanish_garcia";
    }

    final url = "https://quranenc.com/api/translation/sura/$lan/$index";
    var res = await http.get(Uri.parse(url));

    return SurahTranslationList.fromJson(json.decode(res.body));
  }*/

  Future<List<Qari>> getQariList() async {
    final url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));

    jsonDecode(res.body).forEach((element) {
      if (Qarilist.length <20){
        Qarilist.add(Qari.fromJSON(element));
      }
    });

    Qarilist.sort((a,b) => a.name!.compareTo(b.name!));
    return Qarilist;
  }
}