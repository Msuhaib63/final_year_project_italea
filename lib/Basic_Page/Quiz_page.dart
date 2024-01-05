import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:final_year_project_italea/Widget/SideDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constant/color.dart';
import '../Constant/profilepicture.dart';
import '../Content/Quiz/Quiz_intro.dart';
//import '../Database/localDB.dart';
import '../Service/Quiz_service.dart';
import '../Widget/NavBar.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  late List quiz = [];
  bool isLoading  = true;

  final currentUser = FirebaseAuth.instance.currentUser!;

  getQuiz() async {
    await QuizFire.getquiz().then((returned_quiz) {
      // Filter out quizzes with null or invalid 'created_data' timestamps
      returned_quiz = returned_quiz.where((quiz) => quiz["created_data"] is Timestamp).toList();

      // Sort the quizzes based on the 'created_data' timestamp in ascending order (earliest to latest)
      returned_quiz.sort((a, b) =>
          (a["created_data"] as Timestamp).compareTo(b["created_data"] as Timestamp));

      setState(() {
        quiz = returned_quiz;
        isLoading = false;
      });
    });
  }

  late Map<String, dynamic> TopPlayer;
  getTopPlayer() async{
    await FirebaseFirestore.instance.collection("Users").orderBy("point" ,descending: true).get().then((value) {
      setState(()  {
        TopPlayer =  value.docs.elementAt(0).data();
      });
    });
  }

  void initState() {
    super.initState();
    getQuiz();
    getTopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: isLoading ? Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quiz Section" , style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.w700),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40 , vertical: 20),
                child: LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ) : RefreshIndicator(
        onRefresh: () async{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuizPage()));
        },
        child: Scaffold(
          appBar: NavBar(context, 'Quiz Section', Icons.info),
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null){
              return Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        CarouselSlider(
                            items: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(profilPic1),
                                      //fit: BoxFit.fill
                                    )
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(profilPic2),
                                      //fit: BoxFit.fill
                                    )
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(profilPic3),
                                      //fit: BoxFit.fill
                                    )
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(profilPic4),
                                      //fit: BoxFit.fill
                                    )
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(profilPic5),
                                      //fit: BoxFit.fill
                                    )
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                                height: 180,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(
                                    microseconds: 800),
                                viewportFraction: 0.8
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(backgroundColor: Colors.purple, radius: 35),
                              CircleAvatar(
                                  backgroundColor: Colors.redAccent, radius: 35),
                              CircleAvatar(backgroundColor: Colors.green, radius: 35),
                              CircleAvatar(
                                  backgroundColor: Colors.yellowAccent, radius: 35),
                            ],
                          ),
                        ),
                        Divider(thickness: 1,color: hexStringToColor("03045E"),indent: 10,endIndent: 10,),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Top Scorer",
                                      style: TextStyle(
                                          fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: hexStringToColor("03045E")
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(TopPlayer["photoUrl"]),
                                        radius: 50,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            TopPlayer["username"].toString().length >=16 ? "${TopPlayer["username"].toString().substring(0,15)}...": TopPlayer["username"],
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              color: hexStringToColor("03045E")
                                            ),
                                          ),
                                          Text("${TopPlayer["point"]} point",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: hexStringToColor("03045E")
                                              ))
                                        ],
                                      )
                                    ],
                                  )
                                ])),
                        Divider(thickness: 1,color: hexStringToColor("03045E"),indent: 10,endIndent: 10,),

                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unlock New Quizzes",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600,
                                  color: hexStringToColor("03045E"),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              ListView.separated(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                separatorBuilder: (_, __) {return const SizedBox(height: 10,);},
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, int index) {
                                  // Ensure index is within the bounds of the quiz list
                                  if (index >= 0 && index < quiz.length) {
                                    // Access quiz data for the current index
                                    var currentQuiz = quiz[index];
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => QuizIntro(
                                                QuizAbout: currentQuiz["about_quiz"],
                                                QuizImgUrl: currentQuiz["quiz_thumbnail"],
                                                QuizDuration: currentQuiz["duration"],
                                                QuizTopics: currentQuiz["topics"],
                                                QuizName: currentQuiz["quiz_name"],
                                                QuizId: currentQuiz["Quizid"],
                                                QuizPrice: currentQuiz["unlock_point"],
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
                                              child: Image.network(
                                                currentQuiz["quiz_thumbnail"] ?? "default_image_url",                                                height: 70,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(currentQuiz["quiz_name"], style: TextStyle(color: hexStringToColor("03045E"), fontWeight: FontWeight.bold, fontSize: 17),),
                                                  Text("Number of Point: ${currentQuiz["unlock_point"]}",
                                                    style: TextStyle(color: hexStringToColor("A19CC5"), fontSize: 13)
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  /*LinearProgressIndicator(
                                                    value: course.completedPercentage,
                                                    backgroundColor: Colors.black12,
                                                    color: hexStringToColor("0077B6"),
                                                  )*/
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Return an empty container if index is out of bounds
                                    return Container();
                                  }
                                },
                                itemCount: quiz.length,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                        Text("v1.0 Made By SUHAIB" , style: TextStyle(fontWeight: FontWeight.bold , color: hexStringToColor("A19CC5")),)
                      ]
                  ),
                ),
              );
              } else if(snapshot.hasError){
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
          ),
      ),
    );
  }
}