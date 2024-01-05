import 'package:final_year_project_italea/Constant/icons.dart';

class Introduction {
  String thumbnail;
  String name;
  String info;

  Introduction({
    required this.name,
    required this.info,
    required this.thumbnail,
  });
}

List<Introduction> introductionList = [
  Introduction(
    name: 'Quran Section',
    info: 'Reading the Quran with colour-coded guidance of Tajweed law',
    thumbnail: icCourse1,
  ),
  Introduction(
    name: 'Learn Tajweed Section',
    info: 'Has a comprehensive Tajwid learning syllabus, interactive exercises and gamification elements',
    thumbnail: icCourse2,
  ),
  Introduction(
    name: 'Quiz Section',
    info: 'Has a fun quiz section that will assess your knowledge of the knowledge of Tajweed that has been learned',
    thumbnail: icCourse3,
  ),
];