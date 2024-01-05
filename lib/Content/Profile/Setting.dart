import 'package:final_year_project_italea/Widget/SecNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../Sub_Page/Log_Register/Login_page.dart';
import '../../Theme/theme_provider.dart';
import '../../Widget/Custom_backicon.dart';

class QuizQuestion {
  String correctAnswer;
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  String question;
  String questionInfo;
  String infoAnswer;
  int point;

  QuizQuestion({
    required this.correctAnswer,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.question,
    required this.questionInfo,
    required this.infoAnswer,
    required this.point

  });

  Map<String, dynamic> toMap() {
    return {
      'correctAnswer': correctAnswer,
      'opt1': opt1,
      'opt2': opt2,
      'opt3': opt3,
      'opt4': opt4,
      'question': question,
      'questionInfo': questionInfo,
      'infoAnswer' : infoAnswer,
      'point' : point
    };
  }

}

void addOrUpdateQuestion(String quizID, String quePoint, QuizQuestion question) {
  FirebaseFirestore.instance
      .collection("quiz")
      .doc(quizID)
      .collection("questions")
      .where("point", isEqualTo: quePoint)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      // Update existing question
      String docID = querySnapshot.docs.first.id;
      FirebaseFirestore.instance
          .collection("quiz")
          .doc(quizID)
          .collection("questions")
          .doc(docID)
          .update(question.toMap());
    } else {
      // Add new question
      FirebaseFirestore.instance
          .collection("quiz")
          .doc(quizID)
          .collection("questions")
          .add(question.toMap());
    }
  });
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Example usage
            String quizID = "Al-Fatihah";
            String quePoint = "your_que_point";
            QuizQuestion question = QuizQuestion(
              questionInfo: "",
              infoAnswer: "Kata إِيَّاكَ dibaca dengan tafkheem, iaitu memberikan tekanan dan kekuatan pada huruf-hurufnya.",
              correctAnswer: "Tafkheem",
              opt1: "Madd",
              opt2: "Idgham",
              opt3: " Tanwin Dammah",
              opt4: "Tafkheem",
              question: "Bagaimana cara membaca kata إِيَّاكَ dalam Surah Al-Fatihah?",
              point: 4
            );

            addOrUpdateQuestion(quizID, quePoint, question);
          },
          child: Text(
              "Log Out"
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
              top: 40
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //TopBar
              SecNavBar(title: "Setting"),
              const SizedBox(height: 15),

            ],
          ),
        ),
      ),
    );
  }
}
