import 'dart:async';

import 'package:final_year_project_italea/Basic_Page/Quiz_page.dart';
import 'package:final_year_project_italea/Service/FireStore_service.dart';
import 'package:final_year_project_italea/Widget/Quiz_Widget/Lifeline_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../Constant/color.dart';
import '../../Service/Quiz_service.dart';
import 'Loser.dart';
import 'Question.dart';
import 'ResultPage.dart';
import 'Winner.dart';

class Question1 extends StatefulWidget {

  final String QuizId;
  final int QuePoint;
  int? questionCount;
  int? result;

  Question1({
    Key? key,
    required this.QuizId,
    required this.QuePoint,
    this.questionCount,
    this.result,
  }) : super(key: key);

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {

  QuestionModel questionModel = new QuestionModel();
  AudioPlayer player = AudioPlayer();
  int questionCount = 1;
  int result = 0;
  //final player = AudioCache();

  getQuestion() async {
    await QuizQuesCreator.getQuizQue(widget.QuizId, widget.QuePoint).then((queData){
      setState(() {
        questionModel.question = queData["question"];
        questionModel.correctAnswer = queData["correctAnswer"];
        questionModel.questionInfo = queData["questionInfo"];
        questionModel.infoAnswer = queData["infoAnswer"];

        List options = [
          queData["opt1"],
          queData["opt2"],
          queData["opt3"],
          queData["opt4"],
        ];
        options.shuffle();

        questionModel.option1 = options[0];
        questionModel.option2 = options[1];
        questionModel.option3 = options[2];
        questionModel.option4 = options[3];
      });
    });
  }

  bool opt1Locked = false;
  bool opt2Locked = false;
  bool opt3Locked = false;
  bool opt4Locked = false;

  int maxSeconds =  60;
  int seconds = 60;
  Timer? timer;

  QueTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) {

      setState(() => seconds--);
      if(seconds==0){
        timer?.cancel();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>
                ResultPage(QuizID: widget.QuizId,
                  QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)));
      }
    });
  }

  playLocal() async {
    if(widget.QuePoint != 4){
      await player.setAsset('assets/audio_/QUESTION.mp3');
      await player.play();
    }
  }

  playLock() async {
    await player.setAsset('assets/audio/LOCK_SCREEN.mp3');
    await player.play();
  }
//TASK - ADD OTHER SOUND EFFECTS TO THE APP

  playLosserSound() async {
    await player.setAsset('assets/audio/WRONG_ANSWER.mp3');
    await player.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    player.dispose();
  }

  @override
  void initState() {
    super.initState();
    getQuestion();
    playLocal();
    QueTimer();
    questionCount = widget.questionCount ?? 0;
    result = widget.result ?? 0;
  }

  @override
  Widget build(BuildContext context) {

    Future<bool?> showWarning({ required  BuildContext context, required String title, required String content}) async => showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context , false),
                child: Text("No!")
            ),
            ElevatedButton(
                onPressed: () async{
                  await FireStoreDB.updatePoint( widget.QuePoint == 4 ? 0 : widget.QuePoint~/2);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Okay!")
            ),
          ],
        )
    );

    return WillPopScope(
      onWillPop: () async {
        final exitQuiz = await showWarning(
            context: context,
            title: "DO YOU WANT TO EXIT QUIZ ?" ,
            content : "You Will Get Rs.${ widget.QuePoint == 4 ? 0 : widget.QuePoint~/2} In Your Account.");
        return exitQuiz ?? true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.QuePoint} Point",
            style: TextStyle(
                fontSize: 20
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ),
              onPressed: () {
                // Handle the action when the icon is pressed
                showInfoPopup(
                  context,
                  questionModel.infoAnswer,
                );
              },
            ),
          ],
        ),
        //drawer: LifelineDrawer(point: widget.QuePoint),
        floatingActionButton: ElevatedButton(
            child: Text(
              'Quit Game',
              style: TextStyle(
                fontSize: 25,
                color: hexStringToColor("03045E"),
              ),),
            onPressed: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                title: Text("DO YOU WANT TO QUIT THE GAME"),
                content: Text("You will get ${widget.QuePoint == 4 ? 0 : widget.QuePoint~/2} Point."),
                actions: [
                  ElevatedButton( onPressed: ()async{
                    await FireStoreDB.updatePoint(widget.QuePoint == 4 ? 0 : widget.QuePoint~/2);
                    timer?.cancel();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }, child: Text("Quit")),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    child: Text("Cancel"),
                  )
                ],
              ));
            }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: LinearProgressIndicator(
                minHeight: 10,
                value: questionCount / 5, // Assuming you have 5 questions in total
                valueColor: AlwaysStoppedAnimation<Color>(hexStringToColor("03045E")),
                backgroundColor: Colors.grey,
              ),
            ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(value: seconds/maxSeconds, strokeWidth: 10, backgroundColor: hexStringToColor("03045E"),),
                      Center(child: Text(seconds.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: hexStringToColor('03045E')),))
                    ],
                  ),
                ),
                Text("Question number: ${questionCount} / 5", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),)
              ],
            ),
            SizedBox(height: 20),

            Flexible(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: hexStringToColor("03045E"),
                    width: 5, // You can change the border width here
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: .40,
                    ), //BoxShadow
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      questionModel.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: hexStringToColor("03045E"),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      questionModel.questionInfo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: hexStringToColor("03045E"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            InkWell(
              onTap: () {
                print("DOUBLE TAP TO LOCK THE ANSWER");
              },
              onLongPress: () {
                playLock();
                timer?.cancel();
                setState(() {
                  opt1Locked = true;
                });

                Future.delayed(Duration(seconds: 3), () async {
                  if (questionModel.correctAnswer == questionModel.option1) {
                    print("This is right");
                    questionCount++;
                    result++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                  QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint) * 2,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  } else {
                    print("This is wrong");
                    await FireStoreDB.updatePoint((widget.QuePoint ~/ 2));
                    playLosserSound();
                    questionCount++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint > 1) ? (widget.QuePoint ~/ 2) : 1,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                    color: opt1Locked
                        ? Colors.greenAccent.withOpacity(0.8)
                        : hexStringToColor("03045E"),
                    borderRadius: BorderRadius.circular(34)),
                child: Text(
                  "A. ${questionModel.option1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("DOUBLE TAP TO LOCK THE ANSWER");
              },
              onLongPress: () {
                playLock();
                timer?.cancel();
                setState(() {
                  opt2Locked = true;
                });

                Future.delayed(Duration(seconds: 3), () async {
                  if (questionModel.correctAnswer == questionModel.option2) {
                    print("This is right");
                    questionCount++;
                    result++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint) * 2,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  } else {
                    print("This is wrong");
                    await FireStoreDB.updatePoint((widget.QuePoint ~/ 2));
                    playLosserSound();
                    questionCount++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint > 1) ? (widget.QuePoint ~/ 2) : 1,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                    color: opt2Locked ? Colors.greenAccent.withOpacity(0.8) : hexStringToColor("03045E"),
                    borderRadius: BorderRadius.circular(34)),
                child: Text(
                  "B. ${questionModel.option2}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("DOUBLE TAP TO LOCK THE ANSWER");
              },
              onLongPress: () {
                playLock();
                timer?.cancel();
                setState(() {
                  opt3Locked = true;
                });

                Future.delayed(Duration(seconds: 3), () async {
                  if (questionModel.correctAnswer == questionModel.option3) {
                    print("This is right");
                    questionCount++;
                    result++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint) * 2,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  } else {
                    print("This is wrong");
                    await FireStoreDB.updatePoint((widget.QuePoint ~/ 2));
                    playLosserSound();
                    questionCount++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint > 1) ? (widget.QuePoint ~/ 2) : 1,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                    color: opt3Locked ? Colors.greenAccent.withOpacity(0.8) : hexStringToColor("03045E"),
                    borderRadius: BorderRadius.circular(34)),
                child: Text(
                  "C. ${questionModel.option3}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("DOUBLE TAP TO LOCK THE ANSWER");
              },
              onLongPress: () {
                playLock();
                timer?.cancel();
                setState(() {
                  opt4Locked = true;
                });

                Future.delayed(Duration(seconds: 3), () async {
                  if (questionModel.correctAnswer == questionModel.option4) {
                    print("This is right");
                    questionCount++;
                    result++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint) * 2,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  } else {
                    print("This is wrong");
                    await FireStoreDB.updatePoint((widget.QuePoint ~/ 2));
                    playLosserSound();
                    questionCount++;
                    if (questionCount >= 5) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(QuizID: widget.QuizId,
                                QuePoint: widget.QuePoint, questionCount: questionCount, result: result,)
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Question1(
                            QuizId: widget.QuizId,
                            QuePoint: (widget.QuePoint > 1) ? (widget.QuePoint ~/ 2) : 1,
                            questionCount: questionCount,
                            result: result,
                          ),
                        ),
                      );
                    }
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                    color: opt4Locked ? Colors.greenAccent.withOpacity(0.8) : hexStringToColor("03045E"),
                    borderRadius: BorderRadius.circular(34)),
                child: Text(
                  "D. ${questionModel.option4}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void showInfoPopup(BuildContext context, String infoText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Text(
              infoText,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
