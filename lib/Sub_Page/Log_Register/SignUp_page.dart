import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../Constant/color.dart';
import '../../Constant/icons.dart';

import '../../Database/localDB.dart';
import '../../Home_page.dart';
import 'Login_page.dart';

import '../../Service/Auth_service.dart';

import '../../Widget/Sub_Page_Widget/Auth_button.dart';
import '../../Widget/Sub_Page_Widget/Circular_textfield.dart';
import '../../Widget/Sub_Page_Widget/Square_tile.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _confirmpasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: colorBackground7(context),

          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // Header
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Create your Account',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextFields
                    CircularTextField(text: "Enter UserName", isPasswordType: false, controller: _userNameTextController),
                    const SizedBox(height: 15),
                    CircularTextField(text: "Enter Email Id", isPasswordType: false, controller: _emailTextController),
                    const SizedBox(height: 15),
                    CircularTextField(text: "Enter Password", isPasswordType: true, controller: _passwordTextController),
                    const SizedBox(height: 15),
                    CircularTextField(text: "Enter Confirm Password", isPasswordType: true, controller: _confirmpasswordTextController),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    authButton(context, "Sign Up", () async {
                      if(_passwordTextController.text != _confirmpasswordTextController.text){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password do not match"),
                          ),
                        );
                        return;
                      }

                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text
                        );

                        // Creating user document in Firestore
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(userCredential.user!.uid)
                            .set({
                          'userID' : userCredential.user!.uid,
                          'email' : _emailTextController.text,
                          'username' : _userNameTextController.text.isEmpty ? '' : _userNameTextController.text,
                          'bio' : 'empty bio..',
                          'photoUrl' : picProfileDefault,
                          'rank' : 'NA',
                          'point' : 0,
                          'position' : 'user'
                        }).then((value) async {
                          print("User Registered Successfully");
                        });

                        print("Created New Account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const HomePage())
                        );

                      } on FirebaseAuthException catch (error) {
                        Get.snackbar(
                            "About User", "User message",
                            backgroundColor: hexStringToColor("6985e8"),
                            snackPosition: SnackPosition.BOTTOM,
                            titleText: Text(
                              "Account Creating Failed",
                              style: TextStyle(color: Colors.white),
                            ),
                            messageText: Text(
                              error.toString(),
                              style: TextStyle(color: Colors.white),
                            ));
                      }
                    }),
                    const SizedBox(height: 20,),

                    // Divider and Social Media Sign Up Options
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "Or Sign up with",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),

                    // Social Media Tiles
                    Center(
                      child: SignInButton(
                        Buttons.google,
                        onPressed: () => AuthService().signInWithGoogle(context),
                      ),
                    ),
                    SizedBox(height: 70),

                    // Login Option
                    LogInOption(),
                  ],
                ),
              )
          )
      ),
    );
  }

  // Login Option Row
  Row LogInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            " Click Here",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
