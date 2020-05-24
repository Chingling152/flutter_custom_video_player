import 'package:custom_video_player/custom_video_player.dart';
import 'package:custom_video_player/video_player_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState()=> MainPageState();
}

class MainPageState extends State<MainPage> {

  String path = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  VideoPlayerType type = VideoPlayerType.Network;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Custom Video Player"),
      ),
      body:Container(
        color:Colors.white,
        padding: EdgeInsets.symmetric(vertical:20,horizontal:20),
        child:Column(
          children: <Widget>[
            Container(
              color:Colors.black12,
              child:Column(
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.symmetric(vertical:20) ,
                    child:Text("Title")
                  ),
                  Container(
                    child:CustomVideoPlayer(path:path,type: type,autoPlay: false)
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}