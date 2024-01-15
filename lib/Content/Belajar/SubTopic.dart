import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../Constant/color.dart';
import '../../Constant/icons.dart';
import '../../Module/Belajar/Lesson.dart';
import '../../Widget/Belajar_Widget/Topic_Widget/Custom_tabview.dart';
import '../../Widget/Belajar_Widget/Topic_Widget/Description.dart';
import '../../Widget/Custom_backicon.dart';

class SubTopic extends StatefulWidget {

  final String name;
  final String intro1;
  final String intro2;
  final String info;
  final String durCourse;
  final int courseNum;
  final int noOfSubTopic;
  final String pdf1;
  final String pdf2;
  List<Lesson> lessons;

  // Constructor
  SubTopic({
    Key? key,
    required this.name,
    required this.intro1,
    required this.intro2,
    required this.info,
    required this.durCourse,
    required this.courseNum,
    required this.noOfSubTopic,
    required this.lessons,
    required this.pdf1,
    required this.pdf2
  }) : super(key: key);

  @override
  State<SubTopic> createState() => _SubTopicState();
}

class _SubTopicState extends State<SubTopic> {

  // State variables
  int _selectedTag = 0;
  bool playArea = false;
  List videoInfo=[];
  bool isPlaying = false;
  bool _dispose = false;
  int isPlayingIndex = -1;
  VideoPlayerController? _controller;
  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;

  // Method to change the selected tab
  @override
  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  // Initialize data (placeholder method, replace with actual data loading logic)
  void _initData() async {
    // Assuming widget.courseNum contains the course number you want to filter
    int targetCourseNumber = widget.courseNum; // Change this to the desired course number

    List<Lesson> lessons = lessonList ?? [];

    // Filter lessons based on the condition (part1 == courseNum)
    List<Lesson> filteredLessons = lessons.where((lesson) => lesson.part == targetCourseNumber).toList();

    setState(() {
      widget.lessons = filteredLessons;
    });
  }

  // Override initState method to initialize the state
  @override
  void initState(){
    super.initState();
    _initData();
    //_onTapVideo(-1);
  }

  // Override dispose method to clean up resources
  @override
  void dispose(){
    _dispose = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  // Override build method to create the widget tree
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: Container(
            decoration: colorBackground3(context),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                playArea == false
                    ? _buildHeaderSection(context)
                    : _buildPlayAreaHeader(context),

                // Expanded content section
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Tab view and content based on the selected tab
                          CustomTabView(
                            index: _selectedTag,
                            changeTab: changeTab,
                            noOfSubTopic: widget.noOfSubTopic,
                          ),
                          _selectedTag == 0 ? _listView() : Description(pdf1: widget.pdf1, pdf2: widget.pdf2),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  // Header section when play area is false
  Widget _buildHeaderSection(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 30, bottom: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header content
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 300,
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: hexStringToColor("fefeff"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: CustomIconButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: hexStringToColor("fefeff"),
                    ),
                    height: 35,
                    width: 35,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.info_outline, color: Colors.white,),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              widget.intro1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: hexStringToColor("fefeff"),
              ),
            ),
            SizedBox(height: 2),
            ReadMoreText(
              widget.intro2,
              trimLines: 2,
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimCollapsedText: "Show more",
              trimExpandedText: "Show less",
              lessStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent
              ),
              moreStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent
              ),
              style: TextStyle(
                fontSize: 15,
                color: hexStringToColor("fefeff"),
              ),
            ),
            SizedBox(height: 20),
            // Course details
            Row(
              children: [
                // Duration
                Container(
                  width: 150,
                  height: 30,
                  decoration: colorBackground4(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 20,
                        color: hexStringToColor("fafafe"),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.durCourse,
                        style: TextStyle(
                          fontSize: 13,
                          color: hexStringToColor("fafafe"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                // Additional info
                Container(
                  width: 150,
                  height: 30,
                  decoration: colorBackground4(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.handyman_outlined,
                        size: 20,
                        color: hexStringToColor("fafafe"),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.info,
                        style: TextStyle(
                          fontSize: 13,
                          color: hexStringToColor("fafafe"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Header section when play area is true
  Widget _buildPlayAreaHeader(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Header content with back button and info button
          Container(
            height: 100,
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Row(
              children: [
                CustomIconButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: hexStringToColor("fefeff"),
                  ),
                  height: 35,
                  width: 35,
                  onTap: () => Navigator.pop(context),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: hexStringToColor("fafafe"),
                )
              ],
            ),
          ),
          // Play area view and controls
          playView(context),
          controlView(context),
        ],
      ),
    );
  }

  String convertTwo(int value){
    return value < 0 ? "0$value" : "$value";
  }

  Widget controlView(BuildContext context){
    final noMute = (_controller?.value?.volume??0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.red[700],
                inactiveTrackColor: Colors.red[100],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.redAccent,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.red[700],
                inactiveTickMarkColor: Colors.red[100],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.redAccent,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                )
            ),
            child: Slider(
              value: max(0, min( _progress * 100, 100)),
              min: 0,
              max: 100,
              divisions: 100,
              label: _position?.toString().split(".")[0],
              onChanged: (value){
                setState(() {
                  _progress = value * 0.01;
                });
              },
              onChangeStart: (value){
                _controller?.pause();
              },
              onChangeEnd: (value){
                final duration = _controller?.value?.duration;
                if(duration != null){
                  var newValue = max(0, min(value, 99)) * 0.01;
                  var millis = (duration.inMilliseconds * newValue).toInt();
                  _controller?.seekTo(Duration(milliseconds: millis));
                  _controller?.play();
                }
              },
            )
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 5),
          //color: hexStringToColor("6985e8"),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(50, 0, 0, 0)
                          )
                        ]
                    ),
                    child: Icon(
                      noMute ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: (){
                  if(noMute){
                    _controller?.setVolume(0);
                  }else{
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
              ),
              TextButton(
                onPressed: ()async{
                  final index = isPlayingIndex -1;
                  if(index >= 0 && videoInfo.length >= 0){
                    onTapVideo(index);
                  }else {
                    Get.snackbar("Video", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: hexStringToColor("6985e8"),
                        colorText: Colors.white,
                        messageText: Text(
                          "No video ahead!",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        )
                    );
                  };
                },
                child: Icon(
                  Icons.fast_rewind,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: ()async{
                  if(isPlaying){
                    setState(() {
                      isPlaying = false;
                    });
                    _controller?.pause();
                  }else{
                    setState(() {
                      isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: ()async{
                  final index = isPlayingIndex +1;
                  if(index <= videoInfo.length -1){
                    onTapVideo(index);
                  }else {
                    Get.snackbar("Video", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: hexStringToColor("6985e8"),
                        colorText: Colors.white,
                        messageText: Text(
                          "You have finished watching all the videos. Congrats!",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        )
                    );
                  };
                },
                child: Icon(
                  Icons.fast_forward,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              Text(
                "$mins:$secs",
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0,),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget playView(BuildContext context){
    final controller = _controller;
    if(controller != null && controller.value.isInitialized){
      return AspectRatio(
        aspectRatio: 16/9,
        child: VideoPlayer(controller),
      );
    }else{
      return AspectRatio(
          aspectRatio: 16/9,
          child: Center(
            child: Text(
              "Preparing .... ",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ));
    }
  }

  void _onControllerUpdate() async{
    if(_dispose){
      return;
    }

    _onUpdateControllerTime = 0;

    final now = DateTime.now().millisecondsSinceEpoch;

    if(_onUpdateControllerTime > now){
      return;
    }

    _onUpdateControllerTime = now+500;

    final controller = _controller;
    if(controller == null){
      debugPrint("controller is null");
      return;
    }
    if(!controller.value.isInitialized){
      debugPrint("controller can not be initialized");
      return;
    }

    if(_duration == null){
      _duration = _controller?.value.duration;
    }

    var duration = _duration;
    if(duration == null) return;

    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    if(playing){
      if(_dispose) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() / duration.inMilliseconds.ceilToDouble();
      });
    }
    isPlaying = playing;
  }

  onTapVideo(int index) async {
    final controller = VideoPlayerController.network(widget.lessons[index].video);
    final old = _controller;
    _controller = controller;

    if(old!= null){
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller..initialize().then((_){
      old?.dispose();
      isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {});
    });
  }

  _listView(){
    return SizedBox(
      height: 430,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.lessons.length,
          itemBuilder:(_,int index){
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    onTapVideo(index);
                    debugPrint(index.toString()
                    );
                    setState(() {
                      if(playArea == false){
                        playArea = true;
                      }
                    });
                  },
                  child: //_buildCard(index),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: hexStringToColor("03045E"),
                        width: 2, // You can change the border width here
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          blurRadius: 4.0,
                          spreadRadius: .05,
                        ), //BoxShadow
                      ],
                    ),
                    child: _lessonCard(index),
                  )
                ),
                SizedBox(height: 10),
              ],
            );
          }
      ),
    );
  }

  _lessonCard(int index){
    return Row(
      children: [
        Image.asset(
          icPlayLesson,
          height: 45,
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lessons[index].name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: hexStringToColor("03045E")
                ),
              ),
              Text(
                widget.lessons[index].duration,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                    color: hexStringToColor('A19CC5')
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
