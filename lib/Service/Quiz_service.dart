import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';


final currentUser = FirebaseAuth.instance.currentUser!;

class QuizFire{
  static Future<List<Map<String , dynamic>>> getquiz() async {
    List<Map<String, dynamic>> all_quiz = [];
    await FirebaseFirestore.instance
        .collection("quiz")
        .get().then((querySnapshot){
          querySnapshot.docs.forEach((quiz) {
            Map<String, dynamic> myQuiz = quiz.data();
            myQuiz["Quizid"] = quiz.reference.id;
            print(quiz.data());

            all_quiz.add(myQuiz);
          });
        });
    return all_quiz;
  }
}

class QuizUnlock{
  static  Future<bool> buyQuiz({required int QuizPrice ,required String QuizID}) async{
    String user = "";
    bool hasPoint = false;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .get().then((value) async {
          user = value.data().toString();
          hasPoint =  QuizPrice <= value.data()!["point"];
          print(user);
    });

    if(hasPoint){
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.uid)
          .collection("unlocked_quiz")
          .doc(QuizID).set(
          {"unlocked_at" : DateTime.now()}
      );
      //DO YOUR TASK HERE
      print("QUIZ IS UNLOCKED NOW");
      return true;
    }else{
      print("EARN MORE POINT FIRST");
      return false;
    }
  }
}

class CheckQuizUnlock{
  static Future<bool> checkQuizUnlockStatus(String quizID) async{

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid) // Replace "USER_ID" with the actual user ID
        .get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      String userID = userData['userID'];

      bool unlocked = false;

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection("unlocked_quiz")
          .doc(quizID)
          .get().then((value){
            unlocked = value.data().toString() != "null";
          });

      return unlocked;
    } else {
      // User not found
      return false;
    }
}
}

class QuizQuesCreator {
  static Future<Map> getQuizQue(String quizID, int quePoint) async {
    late Map queData;

    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizID)
        .collection("questions")
        //.where("point", isEqualTo: quePoint)
        .get();

    if (value.docs.isNotEmpty) {
      // Generate a random index between 0 and the length of the documents
      int randomIndex = Random().nextInt(value.docs.length);

      // Get the data from the randomly selected document
      queData = value.docs.elementAt(randomIndex).data();
    } else {
      // Handle the case where no documents match the criteria
      queData = {};
    }

    print(queData);
    return queData;
  }
}


class QuestionModel{
  late String question = "";
  late String option1 = "";
  late String option2 = "";
  late String option3 = "";
  late String option4 = "";
  late String correctAnswer = "";
  late String questionInfo = "";
  late String infoAnswer = "";
}