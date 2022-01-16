import 'package:segi_tv/color.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  String content;
  VideoApp(this.content);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.network(widget.content)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),

        
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
             // ignore: deprecated_member_use
             RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: kPrimaryColor)),
      onPressed: () {
          setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
      
      color: kPrimaryColor,
      textColor: Colors.white,
      // child: Text("Play Video".toUpperCase(),
          // style: TextStyle(fontSize: 14)),

           ) ]),
        ),
    
        // ignore: deprecated_member_use
      
      ]  ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
            
        // ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
