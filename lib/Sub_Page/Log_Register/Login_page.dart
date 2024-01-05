import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

import '../../Constant/color.dart';
import '../../Constant/icons.dart';

import '../../Home_page.dart';
import 'Forgotpw_page.dart';
import 'SignUp_page.dart';

import '../../Widget/Sub_Page_Widget/Auth_button.dart';
import '../../Widget/Sub_Page_Widget/Circular_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Controllers for handling user input
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  //final TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        // Apply background decoration
        decoration: colorBackground1(context),

        // Scrollable container to handle small screens
        child: SingleChildScrollView(
          child: Padding(
            // Set padding for the content
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.1, 20, 0),
            child: Column(
              children: <Widget>[
                // Display the login image
                /*Container(
                  width: 300,
                  height: 300,
                  child: Lottie.asset('assets/json/belajar.json'),
                ),*/
                Image.asset(picLogin, fit: BoxFit.fitWidth),
                const SizedBox(height: 30,),

                // Input field for username
                CircularTextField(text: "Enter UserName", isPasswordType: false, controller: _emailTextController),
                const SizedBox(height: 5,),

                // Input field for password
                CircularTextField(text: "Enter Password", isPasswordType: true, controller: _passwordTextController),
                const SizedBox(height: 7,),

                // Forgot Password link
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ForgotPasswordPage();
                            }),
                          );
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 17,),

                // Login button
                authButton(context, "Log in", () async {
                  try{
                    // Attempt to sign in with provided credentials
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text);

                    // Navigate to the home page upon successful login
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomePage()));
                  } catch (error){
                    // Display an error message using GetX Snackbar
                    Get.snackbar(
                        "About User", "User message",
                        backgroundColor: hexStringToColor("6985e8"),
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          "Wrong Username/Password",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        messageText: Text(
                          error.toString(),
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                    );
                  }
                }),

                // Sign-up option
                SignUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for displaying the sign-up option
  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupPage()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}