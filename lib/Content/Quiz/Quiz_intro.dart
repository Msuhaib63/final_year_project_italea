import 'package:final_year_project_italea/Content/Quiz/Question.dart';
import 'package:final_year_project_italea/Content/Quiz/Question1.dart';
import 'package:final_year_project_italea/Widget/SecNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:readmore/readmore.dart';

import '../../Constant/color.dart';
import '../../Constant/profilepicture.dart';
import '../../Service/Quiz_service.dart';
import '../../Widget/Custom_backicon.dart';

class QuizIntro extends StatefulWidget {

  final String QuizName;
  final String QuizImgUrl;
  final String QuizTopics;
  final String QuizDuration;
  final String QuizAbout;
  final String QuizId;
  final int QuizPrice;

  const QuizIntro({
    Key? key,
    required this.QuizAbout,
    required this.QuizDuration,
    required this.QuizImgUrl,
    required this.QuizName,
    required this.QuizTopics,
    required this.QuizId,
    required this.QuizPrice
  }) : super(key: key);

  @override
  State<QuizIntro> createState() => _QuizIntroState();
}

class _QuizIntroState extends State<QuizIntro> {

  AudioPlayer player = AudioPlayer();

  setGoto() async{
    /*await player.setAsset('assets/audio/QUIZ_INTRO.mp3');
    await player.play();*/
    Navigator.push(context, MaterialPageRoute(builder: (context) => Question1(QuizId: widget.QuizId, QuePoint: widget.QuizPrice,)));
  }

  bool quizIsUnlocked = false;
  getQuizUnlockStatus() async{
    await CheckQuizUnlock.checkQuizUnlockStatus(widget.QuizId).then((unlockStatus){
      setState(() {
        quizIsUnlocked = unlockStatus;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getQuizUnlockStatus();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
            child: Text(
              quizIsUnlocked ?
              "START QUIZ" : "UNLOCK QUIZ" ,
              style: TextStyle(
                fontSize: 20,
                color: hexStringToColor("03045E"),
              ),
            ),
            onPressed: () async {
              if (widget.QuizId == "Al-Fatihah") {
                // If the quiz is "Al-Fatihah", allow the user to start the quiz without buying.
                quizIsUnlocked = true;
                setGoto();
              } else {
                // If it's not "Al-Fatihah", check if the user has enough points to unlock.
                quizIsUnlocked
                    ? setGoto()
                    : QuizUnlock.buyQuiz(
                  QuizID: widget.QuizId,
                  QuizPrice: widget.QuizPrice,
                ).then((bought_quiz) {
                  if (bought_quiz) {
                    print("Done Bought");
                    setState(() {
                      quizIsUnlocked = true;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "You do not have enough point to unlock this QUIZ!",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          )
                        ],
                      ),
                    );
                  }
                });
              }
            }

        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SecNavBar(title: widget.QuizName,),
                  const SizedBox(height: 15),
                  Image.network(widget.QuizImgUrl, fit: BoxFit.cover, height: 230 , width: MediaQuery.of(context).size.width,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.QuizTopics , textAlign: TextAlign.center, style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w500, color: hexStringToColor("03045E")),)
                      ],),),


                  quizIsUnlocked ? Container()
                      : Container(
                    padding: EdgeInsets.all(18),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.point_of_sale, color: hexStringToColor("03045E"),),
                            SizedBox(width: 6),
                            Text("How many Point -" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: hexStringToColor("03045E")),),
                          ],
                        ),
                        Text("${widget.QuizPrice} Point" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 17, color: hexStringToColor("03045E")),)                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.av_timer, color: hexStringToColor("03045E"),),
                            SizedBox(width: 6),
                            Text("Duration -" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: hexStringToColor("03045E")),),
                          ],
                        ),
                        Text("${widget.QuizDuration} Minutes" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 17, color: hexStringToColor("03045E")),)                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.topic_outlined, color: hexStringToColor("03045E"),),
                            SizedBox(width: 6),
                            Text("About Quiz -" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: hexStringToColor("03045E")),),
                          ],
                        ),
                        ReadMoreText(
                          widget.QuizAbout,
                          trimLines: 2,
                          textAlign: TextAlign.justify,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "Show more",
                          trimExpandedText: "Show less",
                          lessStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent
                          ),
                          moreStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent
                          ),
                          style: TextStyle(
                              fontSize: 18,
                              color: hexStringToColor("03045E")
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
