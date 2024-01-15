import 'package:final_year_project_italea/Constant/icons.dart';

class Lesson {
  String name;
  String duration;
  String info;
  //bool isPlaying;
  //bool isCompleted;
  String video;
  String thumbnail;
  int part;

  Lesson({
    required this.duration,
    //required this.isCompleted,
    //required this.isPlaying,
    required this.name,
    required this.video,
    required this.info,
    required this.thumbnail,
    required this.part,
  });
}

List<Lesson> lessonList = [

  //topic1
  Lesson(
    duration: '2 min 27 sec',
    //isCompleted: false,
    //isPlaying: true,
    name: "Pengenalan Ilmu Tajwid",
    info: "Teras perbincangan tentang ilmu Tajwid daripada Channel Akademi Quran Pantas Quran Enrichment Centre",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2F1.mp4?alt=media&token=ebc1f15a-df35-4576-8888-c72b51702ee7',
    thumbnail: icCourse4,
    part: 1,
  ),
  Lesson(
    duration: '1 min 45 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengenalan Ilmu Tajwid dari Ust Don",
    info: "Teras perbincangan tentang ilmu Tajwid daripada Ust Don",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F2a.mp4?alt=media&token=cfc6d33d-5bfd-49d9-adb4-1c451de65b4a',
    thumbnail: icCourse1,
    part: 1,
  ),

  //topic2
  Lesson(
    duration: '4 min 39 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Kesalahan Bacaan(Lahn Jali Dan Lahn Khafi) dari Syeikh Hamdy Habeeb Al-Misry",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F3a.mp4?alt=media&token=cef89744-2f1a-4abe-baa9-c8a5a8496bf7',
    info: "Apa Itu Lahn Jali Dan Lahn Khafi? Dan Apa Hukumnya Dalam Solat daripada Sheikh Hamdy Habeeb",
    thumbnail: icCourse4,
    part: 2,
  ),

  //topic3
  Lesson(
    duration: '5 min 41 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Tingkatan Bacaan Al-Quran dari Syeikh Hamdy Habeeb Al-Misry",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F4a.mp4?alt=media&token=63119b6a-fe9f-4a78-83a7-7f20c1a9e17c',
    info: "4 Tingkatan Membaca Al-Quran daripada Sheikh Hamdy Habeeb",
    thumbnail: icCourse4,
    part: 3,
  ),

  //topic4
  Lesson(
    duration: '6 min 30 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Tempat Keluar Huruf (Makhraj)",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F5a.mp4?alt=media&token=0cf852a8-cf4c-423c-9e8c-c55151c38bbc',
    info: "Terdapat 17 organ ucapan",
    thumbnail: icCourse4,
    part: 4,
  ),

  //topic5
  Lesson(
    duration: '1 min 31 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Huruf Hijaiyah Bahasa Arab",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F6a.mp4?alt=media&token=367eaf12-ad76-4808-a28b-891cef83cc3c',
    info: "Terdapat 29 huruf hijaiyah daripada K.B",
    thumbnail: icCourse4,
    part: 5,
  ),
  Lesson(
    duration: '13 min 14 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Cara Menulis dan Menyambung Huruf Arab (Hijaiyyah)",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F7a.mp4?alt=media&token=abb7a2e6-9b8f-45f0-a58f-c2bc1206f67b',
    info: "Cara penulisan dan menyambung tulisan huruf arab dan kedudukannya di permulaan, pertengahan dan hujung perkataan daripada ALMUSTARI - Madrasah Online",
    thumbnail: icCourse4,
    part: 5,
  ),

  //topic6




  //topic7
  Lesson(
    duration: '2 min 04 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Bunyi Asas Huruf Hijaiyah Bahasa Arab",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F8a.mp4?alt=media&token=782a16b6-75fc-4bb6-a8ab-76b82a13cda3',
    info: "Bunyi-Bunyi Asas Bagi Setiap Huruf Hijaiyah Bahasa Arab daripada Online Anakku Pintar Soleh",
    thumbnail: icCourse4,
    part: 7,
  ),
  Lesson(
    duration: '1 min 34 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Caran Sebutan Huruf Hijaiyah Yang Betul",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F9a.mp4?alt=media&token=3f5d208a-0ea8-4e45-b989-c6c6c6da15a8',
    info: "Bunyi-Bunyi Asas Bagi Setiap Huruf Hijaiyah Bahasa Arab daripada KMP Academy",
    thumbnail: icCourse4,
    part: 7,
  ),


  //topic8
  Lesson(
    duration: '3 min 03 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pergertian Makhraj Huruf",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F10a.mp4?alt=media&token=c471d45b-909f-4931-a71d-7562a49aba79',
    info: "Pergertian Makhraj Huruf Bahasa Arab daripada Channel Syukran.com",
    thumbnail: icCourse4,
    part: 8,
  ),
  Lesson(
    duration: '5 min 45 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Makhraj Huruf & Bahagian Makhraj Huruf",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F11a.mp4?alt=media&token=2bc93165-9be0-485e-853a-8f7a8a7e2f75',
    info: "Pembahagian Makhraj Huruf Arab daripada Channel Syahidah Shuib",
    thumbnail: icCourse4,
    part: 8,
  ),

  //topic9
  Lesson(
    duration: '5 min 52  sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Bahagian Rongga Mulut, Rongga Kerongkong dan Kerongkong",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F12a.mp4?alt=media&token=413b0daa-9224-4314-bf08-1bf9036f0426',
    info: "Bahagian Rongga Mulut, Rongga Kerongkong (الجَوْفُ) dan Bahagian Kerongkong (الحَلْقُ) daripada Uda Ridwan Channel",
    thumbnail: icCourse4,
    part: 9,
  ),
  Lesson(
    duration: '8 min 37 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Bahagian Lidah(اللِّسَانُ)(1)",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F13a.mp4?alt=media&token=218c9a62-1061-40fe-b361-e89e76a5eadc',
    info: "Bahagian lidah(Pangkal/Tepi/Tengah Lidah) daripada Uda Ridwan Channel",
    thumbnail: icCourse4,
    part: 9,
  ),
  Lesson(
    duration: '12 min 06 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Bahagian Lidah(اللِّسَانُ)(2)",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F14a.mp4?alt=media&token=d798ee52-9db2-45be-b312-8e8ac9bdfd73',
    info: "Bahagian lidah(Hujung Lidah) daripada Uda Ridwan Channel",
    thumbnail: icCourse4,
    part: 9,
  ),
  Lesson(
    duration: '-',
    //isCompleted: true,
    //isPlaying: true,
    name: "Bahagian Bibir Mulut dan Hidung/Khaisyum",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2F12.mp4?alt=media&token=0e941f0f-8a38-4f53-bc78-6e14f087556e',
    info: "Bahagian Bibir Mulut dan Hidung/Khaisyum (الخَيْشُومُ) daripada -",
    thumbnail: icCourse4,
    part: 9,
  ),

  //topic10
  Lesson(
    duration: '2 min 35 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Cara Mengetahui Makhraj Huruf",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F15a.mp4?alt=media&token=f902120f-2af0-44c2-b0ee-cc9d9c40e059',
    info: "Cara Mengetahui Makhraj Huruf daripada Saluran Rasmi Mohd Izwanuddin Abd Rahim",
    thumbnail: icCourse4,
    part: 10,
  ),

  //topic11
  Lesson(
    duration: '2 min 44 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengertian Sifat Huruf",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F16a.mp4?alt=media&token=67995c6c-31e8-4467-9064-39a428fe5e57',
    info: "Pengertian Sifat Huruf daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 11,
  ),
  Lesson(
    duration: '1 min 19 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pembahagian Sifat Huruf",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F17a.mp4?alt=media&token=29fc3aec-d58d-4286-ae06-7c55b5de5a66',
    info: "Pembahagian Sifat Huruf daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 11,
  ),

  //topic12
  Lesson(
    duration: '3 min 12 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengenalan Bahagian Sifat Huruf Berlawan 10 Sifat",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F18a.mp4?alt=media&token=2385acfa-f346-43cf-bac4-cf3a5c7641e0',
    info: "Pengenalan bahagian sifat huruf berlawan 10 sifat daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 12,
  ),
  Lesson(
    duration: '2 min 58 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Nafas yang mudah atau susah - Sifat Huruf Berlawanan 1",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F19a.mp4?alt=media&token=7684f271-e248-4218-a9c5-afe58206e51c',
    info: "Nafas yang mudah atau susah - Sifat Huruf Berlawanan 1 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 12,
  ),
  Lesson(
    duration: '-',
    //isCompleted: true,
    //isPlaying: true,
    name: "- - Sifat Huruf Berlawanan 1",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2F18.mp4?alt=media&token=58419039-3b32-404d-8383-33eb71e6983f',
    info: "- - Sifat Huruf Berlawanan 1 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 12,
  ),
  Lesson(
    duration: '2 min 43 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Arah suara keatas atau kedepan - Sifat Huruf Berlawanan 3",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F20a.mp4?alt=media&token=10d9f731-7718-4726-80d0-02cf86443b4c',
    info: "Arah suara keatas atau kedepan - Sifat Huruf Berlawanan 3 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 12,
  ),
  Lesson(
    duration: '-',
    //isCompleted: true,
    //isPlaying: true,
    name: "Lidah yang hampir atau jauh - Sifat berlawanan 4",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2F18.mp4?alt=media&token=58419039-3b32-404d-8383-33eb71e6983f',
    info: "Lidah yang hampir atau jauh - Sifat berlawanan 4 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 12,
  ),
  Lesson(
    duration: '2 min 58 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sebutan jarak dalam atau luar - Sifat Berlawanan 5",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F22a.mp4?alt=media&token=5a707758-3504-456a-bead-8538b1ae9d04',
    info: "Sebutan jarak dalam atau luar - Sifat Berlawanan 5 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 12,
  ),

  //topic13
  Lesson(
    duration: '1 min 38 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengenalan sifat huruf yang tidak berlawan ada 7 sifat",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F23a.mp4?alt=media&token=4baf06c6-2a3a-4a71-b9c4-e356beb971b9',
    info: "Pengenalan sifat huruf yang tidak berlawan ada 7 sifat daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),
  Lesson(
    duration: '1 min 42 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang bersiul صفير - Sifat tidak berlawan 1",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F24a.mp4?alt=media&token=58f16a86-4dc0-40ff-b5cd-75fe634d1be3',
    info: "Sifat yang bersiul صفير - Sifat tidak berlawan 1 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),
  Lesson(
    duration: '2 min 34 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang memantul قلقلة - Sifat tidak berlawan 2",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F25a.mp4?alt=media&token=be2bcbb3-e3a1-4e61-84ec-6800254b0418',
    info: "Sifat yang memantul قلقلة - Sifat tidak berlawan 2 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),Lesson(
    duration: '1 min 39 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang lembut ﻟﻴﻦ - Sifat tidak berlawan 3",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F26a.mp4?alt=media&token=e8ec7c0c-1205-48d8-8224-fbfac45f4c50',
    info: "Sifat yang lembut ﻟﻴﻦ - Sifat tidak berlawan 3 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),Lesson(
    duration: '1 min 27 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang condong ﺇﻧﺤﺮﺍﻑ - Sifat tidak berlawan 4",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F27a.mp4?alt=media&token=3a5fa0ab-486e-4084-bed3-f47595dd2e83',
    info: "Sifat yang condong ﺇﻧﺤﺮﺍﻑ - Sifat tidak berlawan 4 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),Lesson(
    duration: '1 min 37 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang berulang ﺗﻜﺮﻳﺮ - Sifat tidak berlawan 5",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F28a.mp4?alt=media&token=6e022f72-94db-400f-9ee1-34939a06dff6',
    info: "Sifat yang berulang ﺗﻜﺮﻳﺮ - Sifat tidak berlawan 5 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),Lesson(
    duration: '1 min 20 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang meluas ﺗﻔﺸﻰ - Sifat tidak berlawan 6",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F29a.mp4?alt=media&token=b3f55549-02da-4e1d-af0f-e6ec3f3cefde',
    info: "Sifat yang meluas ﺗﻔﺸﻰ - Sifat tidak berlawan 6 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),Lesson(
    duration: '2 min 06 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Sifat yang memanjang إستَطَالة - Sifat tidak berlawan 7",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F30a.mp4?alt=media&token=f1bba5b5-e1f9-45c0-a50a-0e8176a7ab0d',
    info: "Sifat yang memanjang إستَطَالة - Sifat tidak berlawan 7 daripada Channel Syukran .com",
    thumbnail: icCourse4,
    part: 13,
  ),

  //topic14
  //topic15

  //topic16
  Lesson(
    duration: '10 min 55 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengenalan Hukum Nun Sukun Dan Tanwin",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F31a.mp4?alt=media&token=5062e2e9-532f-4ce4-a15a-75b17beb982e',
    info: "Pengenalan Hukum Nun Sukun Dan Tanwin daripada Shahrul Affandi Bin Salleh",
    thumbnail: icCourse4,
    part: 16,
  ),

  //topic17
  Lesson(
    duration: '12 min 22 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Hukum Nun Mati Dan Tanwin (Idzhar, Idgham, Iqlab, Ikhfa') ",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F32a.mp4?alt=media&token=0e6f9ac6-bded-4f3c-a272-0806eeb75788',
    info: "Hukum Nun Mati Dan Tanwin (Idzhar, Idgham, Iqlab, Ikhfa') daripada ALMUSTARI - Madrasah Online",
    thumbnail: icCourse4,
    part: 17,
  ),

  //topic18
  Lesson(
    duration: '4 min',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengenalan Hukum Mim Sukun",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F33a.mp4?alt=media&token=188a292b-1dd9-45ac-831e-9f752dd2f93a',
    info: "Pengenalan Hukum Mim Sukun daripada Syahidah Shuib",
    thumbnail: icCourse4,
    part: 18,
  ),

  //topic19
  Lesson(
    duration: '4 min 27 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Hukum Mim Sukun (Idzhar, Idgham, Ikhfa')",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/vid%2F34a.mp4?alt=media&token=300b69c8-24fe-407d-ade3-05391bdae016',
    info: "Hukum Mim Sukun (Idzhar, Idgham, Ikhfa') daripada Uda Ridwan Channel",
    thumbnail: icCourse4,
    part: 19,
  ),

];
