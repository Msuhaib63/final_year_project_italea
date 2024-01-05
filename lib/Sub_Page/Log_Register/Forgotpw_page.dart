import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Constant/color.dart';
import '../../Constant/icons.dart';
import '../../Widget/Custom_backicon.dart';
import '../../Widget/Sub_Page_Widget/Circular_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  // Function to handle password reset
  Future passwordReset() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password Reset link sent! Check your email'),
            );
          }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: colorBackground8(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Header Section
            Container(
              padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 20,
                  left: 20,
                  right: 20
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width:300,
                      child: Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: CustomIconButton(
                      child: const Icon(Icons.arrow_back, color: Colors.white,),
                      height: 35,
                      width: 35,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: ((MediaQuery.of(context).size.height) *0.1)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 130),
                child: Image.asset(
                    picForgotPass
                )
            ),
            SizedBox(height: 30),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Enter Your Email and we will send you a password request link',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),

            // Email Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CircularTextField(text: "Enter Email ID", isPasswordType: false, controller: _emailTextController),

            ),
            SizedBox(height: 30),

            // Reset Password Button
            MaterialButton(
              onPressed: () {
                passwordReset(); // Call your async function here
              },
              child: Text('Reset Password', style: TextStyle(fontSize: 15),),
              color: hexStringToColor("C4FFF9"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                side: BorderSide(color: Colors.blue), // Specify the border color
              ),
            )
          ],
        ),
      ),
    );
  }
}
