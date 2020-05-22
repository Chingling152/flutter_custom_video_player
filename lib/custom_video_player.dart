import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends State<CustomVideoPlayer>{

  VideoPlayerController _playerController;
  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      color: Colors.black, 
      child:Stack(
        children: <Widget>[
          VideoPlayer(_playerController)
        ],
      )
    );
  }
}