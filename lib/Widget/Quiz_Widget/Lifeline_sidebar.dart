import 'dart:math';

import 'package:flutter/material.dart';

import '../../Content/Quiz/AudiencePoll.dart';

class LifelineDrawer extends StatefulWidget {

  final int point;
  const LifelineDrawer({
    Key? key,
    required this.point
  }) : super(key: key);

  @override
  State<LifelineDrawer> createState() => _LifelineDrawerState();
}

class _LifelineDrawerState extends State<LifelineDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(margin: EdgeInsets.symmetric(vertical: 12), child: Text('Lifeline', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),)),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: 550,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 13,
                    reverse: true,
                    itemBuilder: (context, index){
                      if(2*(pow(2,index+1 )) == widget.point){
                        return ListTile(
                          tileColor: Colors.deepPurpleAccent,
                          leading: Text("${index+1}." ,
                            style: TextStyle(fontSize :  20 ,color:Colors.white),),
                          title: Text("${2*(pow(2,index+1 ))} Point" ,
                            style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black54, fontSize : 20),),trailing: Icon(Icons.circle , color: Colors.purpleAccent,),);
                      }
                      return ListTile(
                        leading: Text(
                          "${index + 1}.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey
                          ),
                        ),
                        title: Text(
                          "${2*(pow(2,index+1 ))} Point",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                        trailing: Icon(Icons.circle),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
