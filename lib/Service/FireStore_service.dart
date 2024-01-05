import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Database/localDB.dart';

class FireStoreDB{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  createNewUser(
      String userID,
      String email,
      String username,
      String bio,
      String photoUrl,
      int point,
      String rank,
      String position,
      ) async {
    final User? current_user = _auth.currentUser;
    if(await getUser()){
      print("USER ALRAEDY EXIST");
    }else{
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(current_user!.uid)
          .set({
        'userID' : userID,
        'email' : email,
        'username' : username.isEmpty ? ' ' : username,
        'bio' : 'empty bio..',
        'photoUrl' : photoUrl,
        'point' : 0,
        'rank' : 'NA',
        'position' : 'user'
      }).then((value) async {
        print("User Registered Successfully");
      });
    }
  }

  static updatePoint(int amount) async{
    if(amount != 2){
      final FirebaseAuth _myauth = FirebaseAuth.instance;

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_myauth.currentUser!.uid)
          .get().then((value) async{

        //await LocalDB.savePoint((value.data()!["point"] + amount).toString());

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(_myauth.currentUser!.uid)
            .update(
            {"point" : value.data()!["point"] + amount});
          });
    }
  }

  Future<bool> getUser(  ) async {
    final User? current_user = _auth.currentUser;
    String user = " ";

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(current_user!.uid)
        .get().then((value) async {
          user = value.data().toString();
          print(user);
        });
    if(user.toString() == "null"){
      return false;
    }else{
      return true;
    }
  }

  Future<String> uploadImageToFirebaseStorage(Uint8List image) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Reference storageReference = FirebaseStorage.instance.ref().child('profilePictures/$uid.jpg');
    UploadTask uploadTask = storageReference.putData(image);
    await uploadTask.whenComplete(() => print('Image uploaded to Firebase Storage'));
    return await storageReference.getDownloadURL();
  }

  void updatePhotoUrl(String newPhotoUrl) async {
    final FirebaseAuth _myauth = FirebaseAuth.instance;

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(_myauth.currentUser!.uid)
        .update({"photoUrl": newPhotoUrl});
  }


}