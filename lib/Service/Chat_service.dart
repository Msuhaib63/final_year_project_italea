import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_italea/Module/Chat/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverID, String message) async {

    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    
    ids.sort();
    String chatRoomID = ids.join("_");
    
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> sendVoiceMessage(String receiverID, String audioFilePath) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    // Upload the audio file to Firebase Storage
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('audio_messages')
        .child(chatRoomID)
        .child('${DateTime.now().millisecondsSinceEpoch}.m4a');

    UploadTask uploadTask = storageReference.putFile(File(audioFilePath));

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String audioFileURL = await taskSnapshot.ref.getDownloadURL();

    // Save the message details in Firestore
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .add({
      'senderID': currentUserID,
      'senderEmail': currentEmail,
      'receiverID': receiverID,
      'audioPath': audioFileURL, // Store the file URL instead of the path
      'timestamp': timestamp,
    });
  }

  Future<void> sendImage(String receiverID, File imageFile) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    // Upload the image file to Firebase Storage
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('image_messages')
        .child(chatRoomID)
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    UploadTask uploadTask = storageReference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    // Save the message details in Firestore
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('message')
        .add({
      'senderID': currentUserID,
      'senderEmail': currentEmail,
      'receiverID': receiverID,
      'imagePath': imageUrl, // Store the image URL instead of the path
      'timestamp': timestamp,
    });
  }
}