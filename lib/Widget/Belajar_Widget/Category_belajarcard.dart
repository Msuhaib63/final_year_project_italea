import 'package:final_year_project_italea/Widget/Belajar_Widget/Like_buitton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/saiz.dart';
import 'package:final_year_project_italea/Module/Belajar/Category.dart';
import 'package:final_year_project_italea/Content/Belajar/Topic.dart';

import '../../Constant/color.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Topic(
            name: widget.category.name,
            cateforyNum: widget.category.categoryNum,
            noOfCourses: widget.category.noOfCourses,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: kCategoryCardImageSize, // Set a fixed height for the image
                child: Image.asset(
                  widget.category.thumbnail,
                  fit: BoxFit.contain, // Ensure the image scales properly
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.category.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: hexStringToColor("03045E"),
              ),
            ),
            Row(
              children: [
                Text(
                  "${widget.category.noOfCourses.toString()} courses",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: hexStringToColor('A19CC5'),
                  ),
                ),
                SizedBox(width: 5,),
                LikeButton(isLiked: isLiked, onTap: toggleLike)
              ],
            ),
          ],
        ),
      ),
    );
  }
}