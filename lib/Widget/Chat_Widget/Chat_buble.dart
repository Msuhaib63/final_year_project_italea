import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String? message;
  final String? imageUrl;
  final Color color;

  const ChatBubble({
    Key? key,
    this.message,
    this.imageUrl,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imageUrl != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageScreen(imageUrl!),
            ),
          );
        }
      },
      child: Hero(
        tag: imageUrl ?? '',
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: imageUrl != null
              ? Image.network(
            imageUrl!,
            width: 150, // Adjust the width as needed
            height: 150, // Adjust the height as needed
            fit: BoxFit.cover,
          )
              : Text(
            message!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Customize as needed
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
