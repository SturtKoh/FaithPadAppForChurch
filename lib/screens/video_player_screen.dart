import 'package:flutter/material.dart';
import 'package:faith_pad_test/models/videos_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoItem   videoItem;
  VideoPlayerScreen({this.videoItem});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  //
  YoutubePlayerController _controller;
  bool _isPlayerReady;

  @override
  void initState(){
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoItem.video.resourceId.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      )
    )..addListener( _listener);
  }

  void _listener(){
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen){
      //
    }
  }

  @override
  void deactivate(){
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    _controller.fitHeight(MediaQuery.of(context).size);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    */
    return Container(
        child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.88),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(children: [
                      YoutubePlayer(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                        showVideoProgressIndicator: false,
                        controlsTimeOut: Duration(seconds: 2),
                        progressIndicatorColor: Colors.red,
                        actionsPadding: EdgeInsets.only(bottom: 50),
                        topActions: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                              ]);
                            },
                          ),
                          Expanded(
                            child: Text(
                              '목록으로',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                        bottomActions: [
                          CurrentPosition(),
                          SizedBox(width: 10.0),
                          ProgressBar(isExpanded: true),
                          SizedBox(width: 10.0),
                          RemainingDuration(),
                          FullScreenButton(),
                        ],
                        onReady: () {

                        },
                      ),
                    ])))));
  }
    /*
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.videoItem.video.title),
      ),
      body: Container(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,

          onReady: (){
            print('Player is ready.');
            _isPlayerReady = true;
          },
        )
      )
    );
  }
  */
}
