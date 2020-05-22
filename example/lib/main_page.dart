import 'package:custom_video_player/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState()=> _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color:Colors.white,
        child:CustomVideoPlayer()
      )
    );
  }
}