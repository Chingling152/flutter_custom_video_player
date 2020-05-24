import 'package:custom_video_player/video_player_enums.dart';
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
  String error;

  VideoPlayerState currentState;
  
  @override
  initState(){
    this.reset();//Define default variables
    this._createPlayerController();//creates a controller
    this.startPlayer();// initialize the video player
    super.initState();
  }

  void reset(){
    setState((){
      currentState = VideoPlayerState.Starting;
    });
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

  void _changeVideoStatus(VideoPlayerState status){
    setState((){
      currentState = status;
    });
  }

  Future startPlayer() async{
    try{
      await _playerController.initialize();
      this._changeVideoStatus(VideoPlayerState.Done);

      if(widget.autoPlay)
        await this.play();
    }catch(e){
      setState(() {
        //hasError = true;
        currentState = VideoPlayerState.OnError;
        error = e.message;
      });
    }
  }

  Future pause() async{
    await _playerController.pause();
    this._changeVideoStatus(VideoPlayerState.Paused);
  }

  Future play() async{
    await _playerController.play();
    this._changeVideoStatus(VideoPlayerState.Playing);
  }

  @override
  dispose(){
    this.currentState = VideoPlayerState.Paused;
    if(_playerController!=null){
      Future(() => _playerController.dispose());
      Future(() =>_playerController.pause());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case VideoPlayerState.Starting:
        return _loadingWidget();
        break;
      case VideoPlayerState.OnError:
        return _buildError();
        break; 
      //case VideoPlayerState.Loading:
      default:
        return _buildPlayer();
    }
  }

  Widget _loadingWidget(){
    return _videoPlayerPlaceholder(
      child:Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        )
      )
    );
  }

  Widget _playerIcon(){
    switch (this.currentState) {
      case VideoPlayerState.Done:
      case VideoPlayerState.Paused:
        return Center(
          child: FlatButton(
            textColor: Colors.white,
            disabledTextColor: Colors.white30,
            onPressed: this.play, 
            child: Icon(Icons.play_circle_outline,size: 72)
          )
        );
        break;
      case VideoPlayerState.Loading:
        return _loadingWidget();
      default:
        return Container();
    }
  }

  Widget _buildPlayer(){
    return _videoPlayerPlaceholder(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: VideoPlayer(_playerController),
            onTap: (){
              switch (this.currentState) {
                case VideoPlayerState.Loading:
                case VideoPlayerState.Playing:
                  this.pause();
                  break;
                case VideoPlayerState.Paused:
                  this.play();
                  break;
                default:
              }
            }
          ),          
          _playerIcon(),
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
    assert(aspectRatio > 0,"AspectRatio must be great than 0");
    return AspectRatio(
      aspectRatio: aspectRatio,
      child:Container(
        color: Colors.black, 
        child:child
      )
    );
  }
}