import 'package:final_year_project_italea/Widget/SecNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_year_project_italea/Widget/Custom_backicon.dart';
import 'package:final_year_project_italea/Widget/Belajar_Widget/Sub_Topic_Widget/Course_container.dart';
import 'package:final_year_project_italea/Module/Belajar/Course.dart';

class Topic extends StatefulWidget {
  
  final String name;
  final int cateforyNum;
  final int noOfCourses;
  const Topic({
    Key? key,
    required this.name,
    required this.cateforyNum,
    required this.noOfCourses,
  }) : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {

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
                //TopBar
                SecNavBar(title: widget.name),
                const SizedBox(height: 15),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 10,);
                    },
                    shrinkWrap: true,
                      itemBuilder: (_, int index) {
                        return CourseContainer(
                          course: (widget.cateforyNum == 1)
                              ? coursesList[index]
                              : (widget.cateforyNum == 2)
                              ? coursesList[index + 4]  // Display the next 3 items
                              : (widget.cateforyNum == 3)
                              ? coursesList[index + 7]
                              : (widget.cateforyNum == 4)
                              ? coursesList[index + 12]
                              : (widget.cateforyNum == 5)
                              ? coursesList[index + 17]
                              : (widget.cateforyNum == 6)
                              ? coursesList[index + 23]
                              : coursesList[index],
                        );
                      },

                    itemCount: (widget.cateforyNum == 1)
                        ? widget.noOfCourses  // Display the first 2 items
                        : (widget.cateforyNum == 2)
                        ? widget.noOfCourses  // Display the next 1 items
                        : (widget.cateforyNum == 3)
                        ? widget.noOfCourses
                        : (widget.cateforyNum == 4)
                        ? widget.noOfCourses
                        : (widget.cateforyNum == 5)
                        ? widget.noOfCourses
                        : (widget.cateforyNum == 6)
                        ? widget.noOfCourses
                        : coursesList.length

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
