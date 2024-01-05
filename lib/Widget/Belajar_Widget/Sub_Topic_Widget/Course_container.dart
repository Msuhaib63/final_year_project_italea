import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';
import 'package:final_year_project_italea/Module/Belajar/Course.dart';

import '../../../Content/Belajar/SubTopic.dart';

class CourseContainer extends StatelessWidget {
  final Course course;
  const CourseContainer({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SubTopic(
                name: course.name,
                intro1: course.intro1,
                intro2: course.intro2,
                info: course.info,
                durCourse: course.durCourse,
                courseNum: course.courseNum,
                noOfSubTopic: course.noOfSubTopic,
                lessons: course.lessons,
                pdf1: course.pdf1,
                pdf2: course.pdf2,
              )
          )
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hexStringToColor("03045E"),
            width: 2, // You can change the border width here
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                course.thumbnail,
                height: 70,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name, style: TextStyle(color: hexStringToColor("03045E"), fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(
                    height: 3,
                  ),
                  Text("Number of Courses: ${course.noOfSubTopic.toString()}",
                    style: TextStyle(color: hexStringToColor("A19CC5"), fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}