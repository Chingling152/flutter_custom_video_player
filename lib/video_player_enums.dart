/// Defines where the video will be loaded 
enum VideoPlayerType{
  /// A Video from internet [Require Internet Permission]
  Network,
  /// A Video from user's device [Require Read Files Permission]
  File,
  /// A Video from project's folder
  Assets,
  @deprecated
  /// A Video loaded from cache
  Cache
}

/// Defines the current state of the video player 
enum VideoPlayerState{
  /// Loading metadata from video
  Starting,
  /// Metadata loaded and ready to play
  Done,
  /// Video is playing
  Playing,
  /// Video is paused
  Paused,
  /// Video is loading
  Loading,
  /// Some error ocurred on load video
  OnError
}