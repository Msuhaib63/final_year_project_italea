// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
//
// class SoundRecorder {
//   FlutterSoundRecorder? _audioRecorder;
//   bool isRecordingInt = false;
//
//   late String pathToSaveAudio;
//
//   bool get isRecording => _audioRecorder!.isRecording;
//
//   Future init() async {
//     _audioRecorder = FlutterSoundRecorder();
//
//
//     pathToSaveAudio = await _getAudioFilePath();
//
//     isRecordingInt = true;
//   }
//
//   void dispose() {
//     if (!isRecordingInt) return;
//
//     _audioRecorder = null;
//
//     isRecordingInt = false;
//   }
//
//   Future _record() async {
//     if (!isRecordingInt) return;
//
//     await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
//   }
//
//   Future _stop() async {
//     if (!isRecordingInt) return;
//
//     await _audioRecorder!.stopRecorder();
//   }
//
//   Future toggleRecording() async {
//     if (_audioRecorder!.isStopped) {
//       await _record();
//     } else {
//       await _stop();
//       await _uploadAudioToFirebase();
//     }
//   }
//
//   Future<String> _getAudioFilePath() async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;
//     return '$appDocPath/audio_example.aac';
//   }
//
//   Future<void> _uploadAudioToFirebase() async {
//     try {
//       File audioFile = File(pathToSaveAudio);
//       String fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';
//
//       Reference storageReference =
//       FirebaseStorage.instance.ref().child('audio/$fileName');
//
//       await storageReference.putFile(audioFile);
//
//       // Get the download URL for the uploaded audio
//       String downloadURL = await storageReference.getDownloadURL();
//
//       // Now you can save this download URL to Firebase Database or use it as needed
//       print('Audio uploaded successfully. Download URL: $downloadURL');
//     } catch (e) {
//       print('Error uploading audio to Firebase: $e');
//     }
//   }
// }
