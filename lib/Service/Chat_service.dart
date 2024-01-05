import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_italea/Module/Chat/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


}