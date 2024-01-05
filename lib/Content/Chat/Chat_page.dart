
import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_italea/Module/Chat/SoundRecorder.dart';
import 'package:final_year_project_italea/Service/Chat_service.dart';
import 'package:final_year_project_italea/Widget/Chat_Widget/Chat_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constant/color.dart';
import '../../Widget/SecNavBar.dart';
import '../../Widget/Sub_Page_Widget/Circular_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage(
      {super.key,
        required this.receiverUserEmail,
        required this.receiverUserID
      });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isRecording = false;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService
          .sendMessage(
          widget.receiverUserID,
          _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
              child: SecNavBar(title: widget.receiverUserEmail),
            ),
            Expanded(
                child: _buildMessageList()
            ),
            _buildMessageInput(),
            const SizedBox(height: 25)
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID,
            _firebaseAuth.currentUser!.uid
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading .... ');
          }

          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Colors.green : Colors.blue;


    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (
              data['senderID'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (
              data['senderID'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.center,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message'], color: color,)
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              enabled: !isRecording,
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.message,
                  color: Colors.grey.withOpacity(0.9),
                ),
                hintText: isRecording ? "Recording..." : "Send Message..",
                labelText: isRecording ? "Recording..." : "Send Message..",
                labelStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.9),
                ),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: hexStringToColor("90E0EF"),
                    width: 3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: hexStringToColor("00849C"),
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              setState(() {});
            },
            icon: Icon(
              isRecording ? Icons.stop : Icons.mic,
              size: 30,
              color: hexStringToColor("00849C"),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.arrow_upward,
              size: 30,
              color: hexStringToColor("00849C"),
            ),
          ),
        ],
      ),
    );
  }

}