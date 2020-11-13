import 'package:cached_network_image/cached_network_image.dart';
import 'package:faith_pad_test/models/videos_list.dart';
import 'package:faith_pad_test/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:faith_pad_test/models/channel_info.dart';
import 'package:faith_pad_test/models/streaming_info.dart';
import 'package:faith_pad_test/utils/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  ChannelInfo _channelInfo;
  VideosList  _videosList;
  Item  _item;
  bool  _loading;
  String _playListId;
  String _nextPageToken;
  ScrollController _scrollController;
  bool _isLiveOn;
  String  _liveVideoId;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos  = List();
    _isLiveOn = false;
    _liveVideoId = '';
    _getChannelInfo();
    _getStreamingInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos() async {
    VideosList  tempVideoList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _nextPageToken = tempVideoList.nextPageToken;
    _videosList.videos.addAll(tempVideoList.videos);
    //  print('videos: ${_videosList.videos.length}');
    setState(() {

    });
  }

  _getStreamingInfo() async {
    StreamingInfo  streaming_info = await Services.getStreamingInfo();
    int vcount = streaming_info.pageInfo.totalResults;

    setState(() {
      if (vcount > 0){
        _liveVideoId = streaming_info.items[0].streaming_id.videoId;
        _isLiveOn = true;
        print('_liveVideoId $_liveVideoId');
        _controller = YoutubePlayerController(
          initialVideoId: _liveVideoId,
          flags: YoutubePlayerFlags(
            isLive: true,
            mute: false,
            autoPlay: true,
          ),
        );
      }
      else{
        _isLiveOn = false;
        _liveVideoId = '';
        print('Live is off _liveVideoId $_liveVideoId');
      }
    });
  }

  Widget build(BuildContext context) {
    if (_isLiveOn == true && _liveVideoId != '') {
      print('Play Live : $_liveVideoId');
      _controller.fitHeight(MediaQuery.of(context).size);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
//         DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeRight
      ]);
      return WillPopScope(
          onWillPop: () async {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            return true;
          },
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
                                'Pastel Painting: Animals',
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
      /*
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('실시간 예배'),
        ),
        body: Container(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            ),
          ),
      );
      */
    } //  if
    else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(_loading ? '로딩중' : '지난 예배 목록'),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildInfoView(),
              Expanded(
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (_videosList.videos.length >=
                        int.parse(_item.statistics.videoCount)) {
                      return true;
                    }
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      _loadVideos();
                    }
                    return true;
                  },
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _videosList.videos.length,
                      itemBuilder: (context, index) {
                        VideoItem videoItem = _videosList.videos[index];
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return VideoPlayerScreen(
                                videoItem: videoItem,
                              );
                            }),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: videoItem.video.thumbnails
                                        .thumbnailsDefault.url,
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(child: Text(videoItem.video.title)),
                                  SizedBox(width: 20),
                                ],
                              )
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }  //  else
  }

  youtubeHierarchy() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fill,
          child: YoutubePlayer(
            controller: _controller,
          ),
        ),
      ),
    );
  }

  _buildInfoView(){
    return _loading
        ? CircularProgressIndicator()
        : Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
            child: Row(
              children:[
                CircleAvatar(
                   backgroundImage: CachedNetworkImageProvider(
                    _item.snippet.thumbnails.medium.url,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  _item.snippet.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 20),
                Text(_item.statistics.videoCount),
                SizedBox(width: 20),
              ]
            ),
          ),
        );
  }
}
