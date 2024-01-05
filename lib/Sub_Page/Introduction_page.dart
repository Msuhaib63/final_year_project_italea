import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../Constant/color.dart';
import '../Constant/icons.dart';

import 'Log_Register/Login_page.dart';

class IntroductionPage extends StatefulWidget {

  const IntroductionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //backgroundColor: Colors.white,
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: colorBackground1(context),
                child: IntroductionScreen(
                  pages: [

                    // Page 1: Quran Section
                    PageViewModel(
                      title: "Quran Section",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Reading the Quran with colour-coded guidance of Tajweed law",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)
                            ),
                          )
                        ],
                      ),
                      image: Center(child: Image.asset(picQuran)),
                    ),

                    // Page 2: Learn Tajweed Section
                    PageViewModel(
                      title: "Learn Tajweed Section",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Has a comprehensive Tajweed learning syllabus, interactive exercises and gamification elements",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)
                            ),
                          )
                        ],
                      ),
                      image: Center(child: Image.asset(picQuran)),
                    ),

                    // Page 3: Quiz Section
                    PageViewModel(
                      title: "Quiz Section",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Has a fun quiz section that will assess your knowledge of the knowledge of Tajweed that has been learned",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)
                            ),
                          )
                        ],
                      ),
                      image: Center(child: Image.asset(picQuran)),
                    )
                  ],

                  showSkipButton: true,
                  skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                  showNextButton: true,
                  next: const Icon(Icons.arrow_forward,color: Colors.black,),
                  done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),

                  onDone: () {
                    // Navigate to the login page when the onDone button is pressed
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                  },
                  onSkip: () {
                    // Navigate to the login page when the onSkip button is pressed
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                  },

                  dotsDecorator: DotsDecorator(
                    size: const Size.square(10.0),
                    activeSize: const Size(20.0, 10.0),
                    activeColor: hexStringToColor("00B4D8"),
                    color: hexStringToColor("07BEB8"),
                    spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                  ),
                )
            )
        )
    );
  }
}