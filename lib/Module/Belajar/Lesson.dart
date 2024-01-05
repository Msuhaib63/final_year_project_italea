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

  //topic1.1
  Lesson(
    duration: '-',
    //isCompleted: false,
    //isPlaying: true,
    name: "Pengenalan Ilmu Tajwid(1)",
    info: "10 Asas menjadi teras perbincangan tentang ilmu Tajwid Bahagian 1",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2FSequence%2001.mp4?alt=media&token=275e0c4d-538b-4409-ac26-024b360fd092',
    thumbnail: icCourse4,
    part: 1,
  ),
  Lesson(
    duration: '-',
    //isCompleted: true,
    //isPlaying: true,
    name: "Pengenalan Ilmu Tajwid(2)",
    info: "10 Asas menjadi teras perbincangan tentang ilmu Tajwid Bahagian 2",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2FSequence%2001.mp4?alt=media&token=275e0c4d-538b-4409-ac26-024b360fd092',
    thumbnail: icCourse1,
    part: 1,
  ),

  //topic1.2
  Lesson(
    duration: '11 min 20 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Lahn Jali",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2FSequence%2001.mp4?alt=media&token=275e0c4d-538b-4409-ac26-024b360fd092',
    info: "Apakah itu Kesalahan Nyata atau Lahn Jali",
    thumbnail: icCourse4,
    part: 2,
  ),
  Lesson(
    duration: '11 min 20 sec',
    //isCompleted: true,
    //isPlaying: true,
    name: "Lahn Khafi",
    video: 'https://firebasestorage.googleapis.com/v0/b/fyp-i-talea-e85df.appspot.com/o/Video%2FSequence%2001.mp4?alt=media&token=275e0c4d-538b-4409-ac26-024b360fd092',
    info: "Apakah itu Kesalahan Tersembunyi atau Lahn Khafi",
    thumbnail: icCourse4,
    part: 2,
  ),
];
