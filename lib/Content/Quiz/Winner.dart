import 'package:confetti/confetti.dart';
import 'package:final_year_project_italea/Service/FireStore_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

import 'Question.dart';

class Winner extends StatefulWidget {

  final int QuePoint;
  final String QuizID;

  const Winner({
    Key? key,
    required this.QuizID,
    required this.QuePoint
  }) : super(key: key);

  @override
  State<Winner> createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {

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
                Navigator.pop(context , true)    ;
              } ,
              child: Text("Okay!")
          ),
        ],
      )
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final exitQuiz = await showWarning(context: context , title: "DO YOU WANT TO EXIT QUIZ ?" , content : "You will get Rs.${widget.QuePoint} In Your Account.");
        return exitQuiz ?? false;

      },
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {},
          child: Text("Share with Friends"),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('CONGRATULATION', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold),),
                  Text('YOUR ANSWER IS CORRECT', style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold),),
                  Text('YOU WON', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  Text('${widget.QuePoint} Point', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                  ElevatedButton(child: Text("Next Question"), onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Question(QuizId: widget.QuizID, QuePoint: (widget.QuePoint)*2 )));
                  },)
                ],
              ),
            ),
            buildConfettiWidget(confettiController, pi/2)
          ],
        ),
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection){
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(40,30),
        shouldLoop: false,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 20,
        minBlastForce: 8,
        emissionFrequency: 0.2,
        numberOfParticles: 8,
        gravity: 0.01,
        confettiController: controller,
      ),
    );
  }
}
