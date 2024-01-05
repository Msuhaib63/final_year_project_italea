import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Database/localDB.dart';
import '../Home_page.dart';
import 'FireStore_service.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {

    //try{

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken
    );

    final usercredential = await _auth.signInWithCredential(credential);

    final User? user = usercredential.user;

    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);
    final User? currentUser = await _auth.currentUser;
    assert(currentUser!.uid == user!.uid);

    await FireStoreDB()
        .createNewUser(
      user!.uid.toString(),
      user.email.toString(),
      user.displayName.toString(),
      user.displayName.toString(),
      user.photoURL.toString(),
      user.hashCode,
      user.displayName.toString(),
      user.displayName.toString(),
    );

    print(user);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HomePage())
    );
  }

}