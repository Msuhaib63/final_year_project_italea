import 'package:flutter/material.dart';

import '../../Constant/color.dart';
import '../../Service/FireStore_service.dart';
import 'Question.dart';

class Loser extends StatelessWidget {

  final int point;
  final String correctAnswer;
  final String QuizID;

  const Loser({
    Key? key,
    required this.point,
    required this.correctAnswer,
    required this.QuizID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Question(QuizId: QuizID, QuePoint: (point~/2) )));
        },
        child: Text("Retry"),
      ),
      //backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('OH SORRY!', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold),),
                Text('YOUR ANSWER IS INCORRECT', style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold),),
                Text('CORRECT ANSWER IS ${correctAnswer}', style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold),),
                Text('YOU WON', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                Text('${point== 2 ? 0 : point} Point', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                SizedBox(height: 5),
                Icon(Icons.error_outline,size: 50,),
                SizedBox(height: 5),
                ElevatedButton(
                    child: Text(
                      'Get Reward',
                      style: TextStyle(
                        fontSize: 25,
                        color: hexStringToColor("03045E"),
                      ),),
                    onPressed: (){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        title: Text("DO YOU WANT TO QUIT THE GAME"),
                        content: Text("You will get Rs.${point == 4 ? 0 : point~/2} In Your Account."),
                        actions: [
                          ElevatedButton(onPressed: ()async{
                            await FireStoreDB.updatePoint(point == 4 ? 0 : point~/2);
                          }, child: Text("Quit")),
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          },
                            child: Text("Cancel"),
                          )
                        ],
                      ));
                    }
                )
              ],
            ),
          ),
          //buildConfettiWidget(confettiController, pi/2)
        ],
      ),
    );
  }
}
