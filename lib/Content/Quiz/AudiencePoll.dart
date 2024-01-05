import 'dart:math';

import 'package:flutter/material.dart';

class AudiencePoll extends StatefulWidget {

  final String question;
  final String opt1;
  final String opt2;
  final String opt3;
  final String opt4;
  final String correctAnswer;

  const AudiencePoll({
    Key? key,
    required this.question,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.correctAnswer
  }) : super(key: key);

  @override
  State<AudiencePoll> createState() => _AudiencePollState();
}

class _AudiencePollState extends State<AudiencePoll> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VotingMachine();

  }

  int opt1Votes = 0;
  int opt2Votes = 0;
  int opt3Votes = 0;
  int opt4Votes = 0;
  bool isVoting = true;
  VotingMachine(){
    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        if(widget.opt1 == widget.correctAnswer){
          opt1Votes = Random().nextInt(51) + 50;
        }else{
          opt1Votes = Random().nextInt(40);
        }


        if(widget.opt2 == widget.correctAnswer){
          opt2Votes = Random().nextInt(51) + 50;
        }else{
          opt2Votes = Random().nextInt(40);
        }


        if(widget.opt3 == widget.correctAnswer){
          opt3Votes = Random().nextInt(51) + 50;
        }else{
          opt3Votes = Random().nextInt(40);
        }

        if(widget.opt4 == widget.correctAnswer){
          opt4Votes = Random().nextInt(51) + 50;
        }else{
          opt4Votes = Random().nextInt(40);
        }

        isVoting = false;
      });

      Future.delayed(Duration(seconds: 7), (){
        Navigator.pop(context);
      });

    });


  }
//MAKE  A BETTER UI OF AUDINECE POLL
  //HIDE OPTIONS VOTE WHEN AUDIENCE IS VOTING
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Container(

          margin: EdgeInsets.symmetric(vertical: 250 , horizontal: 20),
          decoration: BoxDecoration(color: Colors.purpleAccent , borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Audience Poll Lifeline" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 27 , color: Colors.white), textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text("Question  - ${widget.question}" , style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17 , color: Colors.white), textAlign: TextAlign.center),
              SizedBox(height: 10,),
              Text(isVoting ? "Audience is Voting" : "Here are the Results" ,  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25 , color: Colors.white) ,  textAlign: TextAlign.center),
              SizedBox(height: 10,),
              isVoting ?  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: LinearProgressIndicator(),
              ) : Container(),
              SizedBox(height: 10,),
              SizedBox(height: 5,),


              Text("${widget.opt1}\t\t${opt1Votes} Votes" ,  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15 , color: Colors.white) ,  textAlign: TextAlign.center),
              SizedBox(height: 3,),
              Text("${widget.opt2}\t\t${opt2Votes} Votes" ,  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15 , color: Colors.white) ,  textAlign: TextAlign.center),
              SizedBox(height: 3,),
              Text("${widget.opt3}\t\t${opt3Votes} Votes" ,  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15 , color: Colors.white) ,  textAlign: TextAlign.center),
              SizedBox(height: 3,),
              Text("${widget.opt4}\t\t${opt4Votes} Votes",   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15 , color: Colors.white) ,  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
