import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share/share.dart';

import '../../Basic_Page/Quiz_page.dart';
import '../../Constant/color.dart';
import '../../Service/FireStore_service.dart';
import 'Question1.dart';

class ResultPage extends StatefulWidget {
  late int questionCount;
  final int result;
  final int QuePoint;
  final String QuizID;

  ResultPage({
    Key? key,
    required this.QuizID,
    required this.QuePoint,
    required this.questionCount,
    required this.result
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  late ConfettiController confettiController;
  AudioPlayer player = AudioPlayer();

  void playWinSound() async {
    await player.setAsset('assets/audio/CORRECT.mp3');
    await player.play();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initController();
    });
    playWinSound();
    confettiController.play();
  }

  void initController(){
    confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  Future<bool?> showWarning({ required  BuildContext context , required String title , required String content}) async => showDialog(
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
                await FireStoreDB.updatePoint( widget.QuePoint);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return QuizPage();
                  }),
                );
              } ,
              child: Text("Okay!")
          ),
        ],
      )
  );
  @override
  Widget build(BuildContext context) {
    // Implement the result page UI using the questionCount
    return WillPopScope(
      onWillPop: ()async{
        final exitQuiz = await showWarning(context: context , title: "DO YOU WANT TO EXIT QUIZ ?" , content : "You will get Rs.${widget.QuePoint} In Your Account.");
        return exitQuiz ?? false;

      },
      child: AlertDialog(
        backgroundColor: hexStringToColor("03045E"),
        content: Container(
          //margin: EdgeInsets.all(40),
          padding: EdgeInsets.all(35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Result",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  )
              ),
              SizedBox(height: 20),
              CircleAvatar(
                child: Text(
                  "${widget.result}/${widget.questionCount}",
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
                radius: 70,
                backgroundColor: widget.result == widget.questionCount / 2
                    ? Colors.yellow
                    : widget.result < widget.questionCount/2
                    ? Colors.red : Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                widget.result == widget.questionCount / 2
                    ? "Almost There"
                    : widget.result < widget.questionCount/2
                    ? "Sorry, Try Again Next Time" : "CONGRATULATION!",
                style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold),),
              Text(
                widget.result == widget.questionCount / 2
                    ? "You Got"
                    : widget.result < widget.questionCount/2
                    ? "You Got" : "YOU WON!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              Text(
                '${widget.QuePoint} Point',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      child: Text(
                        'Get Reward',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight:FontWeight.bold
                        ),),
                      onTap: (){
                        showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text("GOOD JOB, THIS YOUR REWARD!"),
                          content: Text("You will get ${widget.QuePoint == 1 ? 0 : widget.QuePoint} Point."),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await FireStoreDB.updatePoint(widget.QuePoint == 1 ? 0 : widget.QuePoint);
                                Navigator.pop(context);
                                Navigator.pop(context);                      },
                              child: Text("Okay"),
                            ),
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            },
                              child: Text("Wait"),
                            )
                          ],
                        ));
                      }
                  ),

                  SizedBox(height: 10),

                  (widget.result < widget.questionCount / 2
                      ? GestureDetector(
                    child: Text(
                      'Share with Friends',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      String shareContent =
                          "I just won ${widget.QuePoint} points in the quiz! Check it out!";
                      Share.share(shareContent,
                          subject: "Quiz Winner");
                    },
                  )
                      : (widget.result < widget.questionCount/2
                  ? GestureDetector(
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Question1(QuizId: widget.QuizID, QuePoint: (widget.QuePoint~/2) )));
                    },
                  ) :
                  GestureDetector(
                    child: Text(
                      'Share with Friends',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                          fontWeight:FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      String shareContent =
                          "I just won ${widget.QuePoint} points in the quiz! Check it out!";
                      Share.share(shareContent,
                          subject: "Quiz Winner");
                    },
                  )) ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
