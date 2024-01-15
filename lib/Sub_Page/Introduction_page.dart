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

                    // Page 1: Learn Tajweed Section
                    PageViewModel(
                      title: "Bahagian Belajar Tajweed",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "🌟 Selamat datang di Bahagian Belajar Tajweed kami! Temui program pembelajaran Tajweed yang menyeluruh, dilengkapi dengan video pembelajaran berkualiti tinggi yang menarik. Anda juga dapat mengakses nota ringkas dan tambahan dalam format PDF untuk memperkuat pemahaman Tajweed dan memupuk sikap membaca yang efektif. Sertai kami dalam perjalanan pembelajaran yang dinamik! 📖🎉🌈",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16)
                            ),
                          )
                        ],
                      ),
                      image: Center(child: Image.asset(picQuran)),
                    ),
                    // Page 2: Quran Section
                    PageViewModel(
                      title: "Bahagian Quran",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Selamat datang ke aplikasi al-Quran kami yang unik! Nikmati pembacaan al-Quran dengan kod warna tajweed, akses mudah mengikut juz, dengar bacaan Qari pilihan, dan simpan penanda buka anda. Pengalaman al-Quran yang lebih berwarna, teratur, dan penuh inspirasi",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)
                            ),
                          )
                        ],
                      ),
                      image: Center(child: Image.asset(picQuran)),
                    ),

                    // Page 3: Murabbi Section
                    PageViewModel(
                      title: "Bahagian Murabbi",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Selamat datang di Bahagian Murabbi kami! Nikmati perbualan yang lebih interaktif dengan ciri \"Voice Record\" dan kongsi gambar dari kamera atau galeri telefon. Terus hubungi Murabbi atau Ustaz bertauliah dalam Tajweed al-Quran untuk pandangan dan bimbingan yang lebih dekat. Pengalaman berkomunikasi yang dinamik - sertai kami sekarang! 🎙️📸🤲🌟",
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
                      title: "Bahagian Quiz",
                      bodyWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Mari sertai Bahagian Kuiz Tajweed kami! Uji pengetahuan Tajweed anda dalam suasana yang seronok dan interaktif. Kuiz ini direka khas untuk menilai pemahaman anda terhadap hukum-hukum Tajweed yang telah dipelajari sebelum ini. Bergabunglah dalam kuiz ini untuk mengukur kemahiran membaca al-Quran anda dan terus memperkukuhkan pemahaman Tajweed anda. Mari kita uji pengetahuan kita dengan gembira! 🌟📚",
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