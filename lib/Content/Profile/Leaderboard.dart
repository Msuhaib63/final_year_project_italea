import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

import '../../Constant/color.dart';
import '../../Constant/icons.dart';
import '../../Widget/SecNavBar.dart';

class LeaderBoard extends StatefulWidget {

  final String name;
  final int point;
  final String curRank;


  const LeaderBoard({
    Key? key,
    required this.name,
    required this.point,
    required this.curRank
  }) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> LeadersList = [];
  late String rank;

  getLeaders() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .orderBy("point")
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          // Filter out entries with position 'admin'
          LeadersList = querySnapshot.docs
              .where((doc) => doc.data()["position"] == "user")
              .toList()
              .reversed
              .toList();
        });
      } else {
        // Handle the case when there are no leaders.
        print("No leaders found");
        setState(() {
          LeadersList = [];
        });
      }
    } catch (e) {
      print("Error fetching leaders: $e");
      setState(() {
        LeadersList = [];
      });
      // Show a snackbar or display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error fetching leaders. Please try again."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }




  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getLeaders();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            // Replace the following with your own content to share
            String shareContent = "I got ${widget.curRank} in All Around Rank which is i have ${widget.point} point ";

            Share.share(shareContent, subject: "Quiz Winner");
          },
          child: Text("Share with Friends"),
        ),

        body: SafeArea(
          child: LeadersList == null
              ? CircularProgressIndicator()
              : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //TopBar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: const SecNavBar(title: "Leaderboard"),
                  ),
                  const SizedBox(height: 20),

                  LeadersList == null || LeadersList.isEmpty
                      ? const Text("No leaders found")
                      : Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Check if the position is 'user'
                          if (LeadersList[index].data()["position"] == "user") {
                            return ListTile(
                              leading: Text("#${index + 1}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: hexStringToColor("03045E"))),
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white70,
                                    backgroundImage: NetworkImage(LeadersList[index].data()["photoUrl"]),
                                  ),
                                  SizedBox(width: 10),
                                  // Create a local variable for the Text widget
                                  Flexible(
                                    child: Text(
                                      LeadersList[index].data()["username"].toString().length >= 12
                                          ? "${(LeadersList[index].data()["username"]).toString().substring(0, 12)}..."
                                          : (LeadersList[index].data()["username"]).toString(),
                                      style: TextStyle(fontSize: 20, color: hexStringToColor("03045E")),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text("${k_m_b_generator(int.parse(LeadersList[index].data()["point"].toString()))} Point", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: hexStringToColor("03045E"))),
                            );
                          } else {
                            // Return an empty container if the position is 'admin'
                            return Container();
                          }
                        },
                        separatorBuilder: (context, index) => Divider(thickness: 1, color: hexStringToColor("03045E"), indent: 10, endIndent: 10,),
                        itemCount: LeadersList.length,
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
