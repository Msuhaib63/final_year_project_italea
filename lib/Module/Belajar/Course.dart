//import 'package:final_year_project_italea/Constant/icons.dart';
import 'package:final_year_project_italea/Module/Belajar/Lesson.dart';


class Course {
  String name;
  String thumbnail;
  String intro1;
  String intro2;
  String info;
  String pdf1;
  String pdf2;
  String durCourse;
  double completedPercentage;
  int courseNum;
  int noOfSubTopic;
  int part;
  List<Lesson> lessons;
  bool isQuiz;

  Course({
    required this.name,
    required this.thumbnail,
    required this.intro1,
    required this.intro2,
    required this.info,
    required this.pdf1,
    required this.pdf2,
    required this.durCourse,
    required this.completedPercentage,
    required this.courseNum,
    required this.noOfSubTopic,
    required this.part,
    required this.lessons,
    required this.isQuiz,
  });
}

List<Course> coursesList = [

  //Pengenalan Ilmu Tajweed
  Course(
    name: "Ilmu Tajweed",
    thumbnail: "assets/courseIcon/11.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F11.png?alt=media&token=c92ee89a-60e1-47ba-b9af-b7532237a2ee",
    intro1: "Pengenalan Ilmu Tajwid",
    intro2: "Ulama menyatakan setiap ilmu memiliki sepuluh asas utama; termasuk Ilmu Tajwid yang mencakup sepuluh prinsip penting bagi ustaz/ustazah Al-Qur'an. Kepahaman penuh terhadap kesepuluh aspek ini mendatangkan kemuliaan.",
    info: "علمو تجويد",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "4 min 12 sec",
    completedPercentage: .75,
    courseNum: 1,
    noOfSubTopic: 2,
    part: 1,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Kesalahan-Kesalahan Dalam Bacaan Al-Quran",
    thumbnail: "assets/courseIcon/12.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F12.png?alt=media&token=4d246a9a-bdda-4ce5-baa8-448aacd7caf6",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Sesungguhnya ulamak Tajwid Al-Qur'an telah membahagikan kesalahan- kesalahan dalam bacaan Al-Qur'an kepada dua bahagian:",
    info: "اَللَّحْنُ الْجَلِيُّ ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "4 min 39 sec",
    completedPercentage: .75,
    courseNum: 2,
    noOfSubTopic: 1,
    part: 1,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Tingkatan Bacaan Al-Quran",
    thumbnail: "assets/courseIcon/13.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F13.png?alt=media&token=77d563f0-cdac-4ce0-bef5-a0fa95f8ee90",
    intro1: "Apakah itu tingkatan dalam bacaan Al-Quran?",
    intro2: "Terdapat empat tingkatan atau martabat bacaan Al-Qur'an iaitu bacaan dari segi cepat atau perlahan:",
    info: "اَللَّحْنُ الْخَفِيُّ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "5 min 41 sec",
    completedPercentage: .60,
    courseNum: 3,
    noOfSubTopic: 1,
    part: 1,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Organ-organ Ucapan",
    thumbnail: "assets/courseIcon/14.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F14.png?alt=media&token=980ca8ea-a30d-4726-88ec-2bbcfd14c912",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "DevWheels",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "6 min 30 sec",
    completedPercentage: .75,
    courseNum: 4,
    noOfSubTopic: 1,
    part: 1,
    lessons: lessonList,
    isQuiz: false,
  ),

  //Huruf Hijaiyah
  Course(
    name: "Tulisan Huruf Hijaiyah Bahasa Arab",
    thumbnail: "assets/courseIcon/21.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F21.png?alt=media&token=c9b2f9e2-63b7-4bd0-8d44-a738560f2cc3",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "DevWheels",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "14 min 45 sec",
    completedPercentage: .75,
    courseNum: 5,
    noOfSubTopic: 2,
    part: 2,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Tanda-Tanda Bacaan Bahasa Arab",
    thumbnail: "assets/courseIcon/22.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F22.png?alt=media&token=ffcd847b-8417-40c3-9731-d995d1275edb",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "DevWheels",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "-",
    completedPercentage: .75,
    courseNum: 6,
    noOfSubTopic: 0,
    part: 2,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Bunyi-Bunyi Asas Bagi Setiap Huruf Hijaiyah Bahasa Arab",
    thumbnail: "assets/courseIcon/23.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F23.png?alt=media&token=fa404b84-d3c4-41a5-b97a-3af43e3d441f",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "DevWheels",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "3 min 38 sec",
    completedPercentage: .75,
    courseNum: 7,
    noOfSubTopic: 2,
    part: 2,
    lessons: lessonList,
    isQuiz: false,
  ),

  //Makhraj Huruf Al-Quran
  Course(
    name: "Pengenalan Makhraj Huruf",
    thumbnail: "assets/courseIcon/31.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F31.png?alt=media&token=c06a8384-4798-4857-88bc-10aa0197a189",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "DevWheels",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "8 min 48 sec",
    completedPercentage: .75,
    courseNum: 8,
    noOfSubTopic: 2,
    part: 3,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Pembahagian Makhraj Huruf Arab Al-Quran",
    thumbnail: "assets/courseIcon/32.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F32.png?alt=media&token=24abf7eb-d4c0-4172-8ab6-0907d747726d",
    intro1: "Terdapat 5 Bahagian Makhraj Huruf Arab Al-Quran",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْجَوْفُ dan الْحَلْقُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "35 min 23 sec",
    completedPercentage: .75,
    courseNum: 9,
    noOfSubTopic: 4,
    part: 3,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Cara Mengetahui Makhraj Huruf",
    thumbnail: "assets/courseIcon/35.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F35.png?alt=media&token=0847e9ba-bc64-488d-a300-647c6a359e91",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "2 min 35 sec",
    completedPercentage: .75,
    courseNum: 10,
    noOfSubTopic: 1,
    part: 3,
    lessons: lessonList,
    isQuiz: false,
  ),
  //Sifat Huruf Al-Quran
  Course(
    name: "Pengenalan Sifat Huruf",
    thumbnail: "assets/courseIcon/41.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F41.png?alt=media&token=aee7a1f8-5373-4f1f-ad39-e21b648e8ad8",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "4 min 03 sec",
    completedPercentage: .75,
    courseNum: 11,
    noOfSubTopic: 2,
    part: 4,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Sifat-Sifat Berlawanan",
    thumbnail: "assets/courseIcon/42.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F42.png?alt=media&token=1bd634b5-12e8-4650-8899-8058fa3e4b8b",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "11 min 51 sec",
    completedPercentage: .75,
    courseNum: 12,
    noOfSubTopic: 6,
    part: 4,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Sifat-Sifat Tunggal",
    thumbnail: "assets/courseIcon/43.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F43.png?alt=media&token=d158e7f1-0107-4f22-a5c0-cab61424f077",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "14 min 03",
    completedPercentage: .75,
    courseNum: 13,
    noOfSubTopic: 8,
    part: 4,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Sifat-Sifat Kuat Dan Lemah",
    thumbnail: "assets/courseIcon/44.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F44.png?alt=media&token=83af0a8c-28cc-428c-9435-0b6dd11d9f08",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "68 min",
    completedPercentage: .75,
    courseNum: 14,
    noOfSubTopic: 0,
    part: 4,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Sifat-Sifat At-Tafkhim",
    thumbnail: "assets/courseIcon/45.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F45.png?alt=media&token=e85037ee-8a53-4e86-ab44-c99f4a8f449b",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "68 min",
    completedPercentage: .75,
    courseNum: 15,
    noOfSubTopic: 0,
    part: 4,
    lessons: lessonList,
    isQuiz: false,
  ),

  //Hukum Nun Sukun Dan Tanwin
  Course(
    name: "Pengenalan Hukum Nun Sukun Dan Tanwin",
    thumbnail: "assets/courseIcon/51.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F51.png?alt=media&token=e57f4cef-5f7c-4aba-8527-d6d30cb47b66",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "10 min 55 sec",
    completedPercentage: .75,
    courseNum: 16,
    noOfSubTopic: 1,
    part: 6,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Hukum Bacaan Al-Izhar",
    thumbnail: "assets/courseIcon/52.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F52.png?alt=media&token=0d38edd7-f3e1-4a66-b702-24ca75697f7b",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "12 min 22 sec",
    completedPercentage: .75,
    courseNum: 17,
    noOfSubTopic: 1,
    part: 6,
    lessons: lessonList,
    isQuiz: false,
  ),


  //Hukum Mim Sukun
  Course(
    name: "Pengenalan Hukum Mim Sukun",
    thumbnail: "assets/courseIcon/61.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F61.png?alt=media&token=da9b0479-587f-4001-aa3d-adc165b7d467",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "4 min",
    completedPercentage: .75,
    courseNum: 18,
    noOfSubTopic: 1,
    part: 7,
    lessons: lessonList,
    isQuiz: false,
  ),
  Course(
    name: "Hukum Bacaan Al-Ikhfa'",
    thumbnail: "assets/courseIcon/62.png",
    //thumbnail: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Icon%2FCourses%2F55.png?alt=media&token=be7af427-d568-4cad-bdb3-5cf4d95245c6",
    intro1: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    intro2: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    info: "الْخَيْشُومُ",
    pdf1: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FNota%20Pengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=0749d1d1-5bd5-473e-8cf6-bda5a8945127",
    pdf2: "https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/pdf%2F1%2FPengenalan%20Ilmu%20Tajweed.pdf?alt=media&token=9e5143e0-8123-4ef6-9485-bb174785b386",
    durCourse: "4 min 27 sec",
    completedPercentage: .75,
    courseNum: 19,
    noOfSubTopic: 1,
    part: 7,
    lessons: lessonList,
    isQuiz: false,
  ),
];
