/*
import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_italea/Module/Chat/Message.dart';
import 'package:final_year_project_italea/Service/Chat_service.dart';
import 'package:final_year_project_italea/Widget/Chat_Widget/Chat_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Constant/color.dart';
import '../../Widget/Chat_Widget/VoiceMessageWidget.dart';
import '../../Widget/SecNavBar.dart';
import '../../Widget/Sub_Page_Widget/Circular_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isRecorderInitialized = false;
  final recorder = FlutterSoundRecorder();
  bool isRecording = false;

  File? _selectedImage;

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }

    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));

    setState(() {
      isRecorderInitialized = true;
    });
  }

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    if (isRecorderInitialized) {
      recorder.closeRecorder();
    }
    _audioPlayer.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }

  Future<void> startRecord() async {
    if (!isRecorderInitialized) {
      // Handle case where the recorder is not initialized
      return;
    }

    // Check if the recorder is already running
    if (recorder.isRecording) {
      // Handle the case where recording is already in progress
      return;
    }

    await recorder.startRecorder(toFile: "audio");
    setState(() {
      isRecording = true;
    });
  }

  Future<void> stopRecorder() async {
    if (!isRecorderInitialized) {
      return;
    }

    // Check if the recorder is not running
    if (!recorder.isRecording) {
      return;
    }

    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');

    setState(() {
      isRecording = false;
    });

    // Save the file to the download folder or perform any other necessary action
    saveFileToDownloads(file);

    // Now, send the voice message to Firestore
    await _chatService.sendVoiceMessage(widget.receiverUserID, filePath);
  }

  void saveFileToDownloads(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final downloadsDir = Directory("${appDocDir.path}/Downloads");

    if (!(await downloadsDir.exists())) {
      await downloadsDir.create(recursive: true);
    }

    final newFilePath = '${downloadsDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
    await file.copy(newFilePath);

    print('File saved to: $newFilePath');
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Handle sending the image to Firestore or perform any other necessary action
      await _chatService.sendImage(widget.receiverUserID, _selectedImage!);
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
            Expanded(child: _buildMessageList()),
            _buildMessageInput(),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
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
      },
    );
  }

*/
/*
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Colors.green
        : Colors.blue;

    if (data.containsKey('message')) {
      // Regular text message
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              ChatBubble(message: data['message'], color: color),
            ],
          ),
        ),
      );
    } else if (data.containsKey('audioPath')) {
      // Voice message
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              VoiceMessageWidget(audioUrl: data['audioPath'], color: color),
            ],
          ),
        ),
      );
    }

    return SizedBox.shrink();
  }
*/
/*


  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Colors.green
        : Colors.blue;

    if (data.containsKey('message')) {
      // Regular text message
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              ChatBubble(message: data['message'], color: color),
            ],
          ),
        ),
      );
    } else if (data.containsKey('audioPath')) {
      // Voice message
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              VoiceMessageWidget(audioUrl: data['audioPath'], color: color),
            ],
          ),
        ),
      );
    }

    return SizedBox.shrink();
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
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
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
            onPressed: isRecording ? stopRecorder : startRecord,
            icon: Icon(
              isRecording ? Icons.stop : Icons.mic,
              size: 30,
              color: hexStringToColor("00849C"),
            ),
          ),
          IconButton(
            onPressed: () => _pickImage(ImageSource.camera),
            icon: Icon(
              Icons.camera_alt,
              size: 30,
              color: hexStringToColor("00849C"),
            ),
          ),
          IconButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            icon: Icon(
              Icons.photo,
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

*/

import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Constant/color.dart';
import '../../Service/Chat_service.dart';
import '../../Widget/Chat_Widget/Chat_buble.dart';
import '../../Widget/Chat_Widget/VoiceMessageWidget.dart';
import '../../Widget/SecNavBar.dart';
import '../../Widget/Sub_Page_Widget/Circular_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isRecorderInitialized = false;
  final recorder = FlutterSoundRecorder();
  bool isRecording = false;

  File? _selectedImage;

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }

    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 300));

    setState(() {
      isRecorderInitialized = true;
    });
  }

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    if (isRecorderInitialized) {
      recorder.closeRecorder();
    }
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }

  Future<void> startRecord() async {
    if (!isRecorderInitialized) {
      return;
    }

    if (recorder.isRecording) {
      return;
    }

    await recorder.startRecorder(toFile: "audio");
    setState(() {
      isRecording = true;
    });
  }

  Future<void> stopRecorder() async {
    if (!isRecorderInitialized) {
      return;
    }

    if (!recorder.isRecording) {
      return;
    }

    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');

    setState(() {
      isRecording = false;
    });

    saveFileToDownloads(file);

    await _chatService.sendVoiceMessage(widget.receiverUserID, filePath);
  }

  void saveFileToDownloads(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final downloadsDir = Directory("${appDocDir.path}/Downloads");

    if (!(await downloadsDir.exists())) {
      await downloadsDir.create(recursive: true);
    }

    final newFilePath = '${downloadsDir.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
    await file.copy(newFilePath);

    print('File saved to: $newFilePath');
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      await _chatService.sendImage(widget.receiverUserID, _selectedImage!);
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
            Expanded(child: _buildMessageList()),
            _buildMessageInput(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
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
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Colors.green
        : Colors.blue;

    if (data.containsKey('message')) {
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              ChatBubble(message: data['message'], color: color),
            ],
          ),
        ),
      );
    } else if (data.containsKey('audioPath')) {
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              VoiceMessageWidget(audioUrl: data['audioPath'], color: color),
            ],
          ),
        ),
      );
    } else if (data.containsKey('imagePath')) {
      return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderID'] == _firebaseAuth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              ChatBubble(imageUrl: data['imagePath'], color: color),
            ],
          ),
        ),
      );
    }

    return SizedBox.shrink();
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
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
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
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'gallery') {
                _pickImage(ImageSource.gallery);
              } else if (value == 'camera') {
                _pickImage(ImageSource.camera);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'gallery',
                child: ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'camera',
                child: ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: isRecording ? stopRecorder : startRecord,
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
