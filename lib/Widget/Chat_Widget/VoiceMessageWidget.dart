import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class VoiceMessageWidget extends StatefulWidget {
  final String audioUrl;
  final Color color;

  VoiceMessageWidget({
    Key? key,
    required this.audioUrl,
    required this.color,
  }) : super(key: key);

  @override
  _VoiceMessageWidgetState createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double _sliderValue = 0.0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Listen for position changes
    _audioPlayer.positionStream.listen((position) {
      final totalDuration = _audioPlayer.duration;
      if (totalDuration != null) {
        setState(() {
          _sliderValue = position.inMilliseconds / totalDuration.inMilliseconds;
        });
      }
    });

    // Initialize playback when the widget is created
    initPlayback();
  }

  Future<void> initPlayback() async {
    await _audioPlayer.setUrl(widget.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: GestureDetector(
        onTap: () async {
          if (_audioPlayer.playing) {
            await _audioPlayer.pause();
          } else {
            // Start playback from the beginning when tapped
            await _audioPlayer.seek(Duration.zero, index: 0);
            await _audioPlayer.play();
          }
          setState(() {}); // Update the UI to reflect the playback state
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _audioPlayer.playing ? 'Playing' : 'Tap to Play',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Slider(
                value: _sliderValue.clamp(0.0, 1.0),
                onChanged: (value) {
                  final position = value * _audioPlayer.duration!.inMilliseconds;
                  _audioPlayer.seek(Duration(milliseconds: position.round()), index: 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
