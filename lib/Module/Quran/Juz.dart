class JuzModel{
  final int juzNumber;
  final List<JuzAyahs> juzAyahs;

  JuzModel({
    required this.juzNumber,
    required this.juzAyahs,
  });

  factory JuzModel.fromJSON(Map<String, dynamic> json){
    Iterable juzAyahs = json['data']['ayahs'];
    List<JuzAyahs> juzAyahList = juzAyahs.map((e) => JuzAyahs.fromJSON(e)).toList();

    return JuzModel(
        juzNumber: json['data']['number'],
        juzAyahs: juzAyahList);
  }
}

class JuzAyahs {
  final String ayahsText;
  final int ayahNumber;
  final String surahName;

  JuzAyahs({
    required this.ayahsText,
    required this.ayahNumber,
    required this.surahName
});

  factory JuzAyahs.fromJSON(Map<String, dynamic> json) {
    return JuzAyahs(
        ayahsText: json['text'],
        ayahNumber: json['number'],
        surahName: json['surah']['name']
    );
  }
}