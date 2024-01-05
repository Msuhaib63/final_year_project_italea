import 'dart:async';

import 'package:flutter/material.dart';

import '../Constant/color.dart';
import '../Constant/icons.dart';

import 'Introduction_page.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {

  @override
  void initState() {
    super.initState();
    // Use a timer to delay navigation to the IntroductionPage
    Timer(const Duration(seconds: 8), ()=>Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>const IntroductionPage())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: colorBackground1(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(2, MediaQuery.of(context).size.height*0.05, 2, 0),
              child: Column(
                children: <Widget>[
                  // Display the loading image
                  Image.asset(picLoad, fit: BoxFit.fitWidth),
                  const SizedBox(height: 100,),

                  // Display the app name
                  const Center(
                    child: Text(
                      'I-TaLea' ,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}