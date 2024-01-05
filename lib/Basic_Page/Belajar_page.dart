import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constant/color.dart';

import '../Module/Belajar/Category.dart';
import '../Widget/Belajar_Widget/Belajar_topbar.dart';
import '../Widget/Belajar_Widget/Category_belajarcard.dart';

class Belajarpage extends StatefulWidget {
  const Belajarpage({Key? key}) : super(key: key);

  @override
  State<Belajarpage> createState() => _BelajarpageState();
}

class _BelajarpageState extends State<Belajarpage> {


  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    // AnnotatedRegion to set SystemUiOverlayStyle
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).snapshots(),
          builder: (context, snapshot){
            if (snapshot.hasData){

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Set to min so that the column only takes the necessary space
                    children: [
                      BelajarTopBar(name: userData['username']),
                      const Body(),

                      const SizedBox(height: 10),
                      Text("v1.0 Made By SUHAIB" , style: TextStyle(fontWeight: FontWeight.bold , color: hexStringToColor('A19CC5')),),
                      const SizedBox(height: 10),
                    ],
                  )
              );
            } else if(snapshot.hasError){
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min, // Set to min so that the column only takes the necessary space
      children: [
        // Explore Categories Section
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cari Tajuk Pelajaran",
                style: TextStyle(
                  color: hexStringToColor("03045E"),
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    crossAxisCount = crossAxisCount == 2 ? 4 : 2;
                  });
                },
                child: Text(
                  "Lihat Semua",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: hexStringToColor("00B4D8")),
                ),
              )
            ],
          ),
        ),

        // GridView for Categories
        GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categoryList[index],
            );
          },
          itemCount: crossAxisCount == 2
              ? 4 // Show only 2x2 items initially
              : categoryList.length,
        ),

      ],
    );
  }
}