import 'package:custom_video_player/video_player_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget{

  final String path;
  final VideoPlayerType type; 

  final bool autoPlay;

  CustomVideoPlayer(
    {
      @required this.path,
      @required this.type,
      this.autoPlay = false
    }
  );

  @override
  State<StatefulWidget> createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends State<CustomVideoPlayer>{

  VideoPlayerController _playerController;

  bool hasError = false;
  String error;

  
  @override
  initState(){
    _createPlayerController();

    if(widget.autoPlay)
      startPlayer();

    super.initState();
  }

  void _createPlayerController(){
    switch (widget.type) {
      case VideoPlayerType.Network:
        _playerController = VideoPlayerController.network(
          widget.path
        );
        break;
      default:
        break;
    }
  }

  Future startPlayer() async{
    try{
      await _playerController.initialize();
      await this.play();
    }catch(e){
      setState(() {
        hasError = true;
        error = e.message;
      });
    }
  }

  Future play() async{
    await _playerController.play();
  }

  @override
  dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(this.hasError)
      return _buildError();
    
    return _buildPlayer();
  }

  Widget _buildPlayer(){
    return _videoPlayerPlaceholder(
      child: Stack(
        children: <Widget>[
          VideoPlayer(_playerController)
        ],
      ),
      aspectRatio: _playerController?.value?.size?.aspectRatio??16/9
    );
  } 

  Widget _buildError(){
    return _videoPlayerPlaceholder(
      child: Center(
        child: Text(this.error,style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,)
      )
    );
  }

  Widget _videoPlayerPlaceholder({@required Widget child,double aspectRatio = 16/9}){
    assert(child != null,"child element cannot be null");
    return AspectRatio(
      aspectRatio: aspectRatio,
      child:Container(
        color: Colors.black, 
        child:child
        )
    );
  }
}