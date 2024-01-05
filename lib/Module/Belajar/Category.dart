import 'package:final_year_project_italea/Constant/icons.dart';

class Category {
  String thumbnail;
  String name;
  int noOfCourses;
  int categoryNum;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
    required this.categoryNum,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Pengenalan Ilmu Tajweed',
    noOfCourses: 5,
    thumbnail: "assets/courseIcon/1.png",
    categoryNum: 1,
  ),
  Category(
    name: 'Huruf Hijaiyah',
    noOfCourses: 4,
    thumbnail: "assets/courseIcon/2.png",
    categoryNum: 2,
  ),
  Category(
    name: 'Makhraj Huruf Al-Quran',
    noOfCourses: 6,
    thumbnail: "assets/courseIcon/3.png",
    categoryNum: 3,
  ),
  Category(
    name: 'Sifat Huruf Al-Quran',
    noOfCourses: 6,
    thumbnail: "assets/courseIcon/4.png",
    categoryNum: 4,
  ),
  Category(
    name: 'Hukum Nun Sukun\n dan Tanwin',
    noOfCourses: 7,
    thumbnail: "assets/courseIcon/5.png",
    categoryNum: 5,
  ),
  Category(
    name: 'Hukum Mim Sukun',
    noOfCourses: 5,
    thumbnail: "assets/courseIcon/6.png",
    categoryNum: 6,
  ),
];