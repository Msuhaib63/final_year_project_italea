import 'package:final_year_project_italea/Basic_Page/Belajar_page.dart';
import 'package:final_year_project_italea/Basic_Page/Quiz_page.dart';
import 'package:final_year_project_italea/Basic_Page/Quran_page.dart';
import 'package:final_year_project_italea/Content/Profile/Leaderboard.dart';
import 'package:flutter/material.dart';

import '../Constant/color.dart';
import '../Constant/icons.dart';
import '../Home_page.dart';
import '../Sub_Page/Log_Register/Login_page.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: colorBackground3(context),
        child: ListView(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 30,
                    backgroundImage: NetworkImage(picProfileDefault),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Text("name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text("hjajaj", style: TextStyle( fontWeight: FontWeight.bold,fontSize: 15),),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Text("Leaderboard", style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            ),
            listItem(
                context: context,
                onTap: () {
                  /*Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const LeaderBoard()));*/
                },                label: "Quiz Leaderboard",
                icon: Icons.leaderboard
            ),
            listItem(
                context: context,
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginPage();
                    },
                  ),
                      (_) => false,
                ),
                label: "About Us",
                icon: Icons.logout
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem({
    required String label,
    required IconData icon,
    required BuildContext context,
    required Function onTap
  }) {
    final color = Colors.black;
    final hovercolor = Colors.black54;

    return ListTile(
      leading: Icon(icon, color: color,),
      hoverColor: hovercolor,
      title: Text(label, style: TextStyle(color: color),),
      onTap: onTap(),
    );
  }
}
