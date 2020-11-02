import 'package:cached_network_image/cached_network_image.dart';
import 'package:faith_pad_test/models/videos_list.dart';
import 'package:faith_pad_test/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:faith_pad_test/models/channel_info.dart';
import 'package:faith_pad_test/utils/services.dart';

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

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos  = List();
    _getChannelInfo();
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading? '로딩중':'명륜교회 온라인 예배'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child:NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification){
                  if (_videosList.videos.length >= int.parse(_item.statistics.videoCount)){
                    return true;
                  }
                  if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent){
                    _loadVideos();
                  }
                  return true;
                },
                child:ListView.builder(
                    controller: _scrollController,
                    itemCount: _videosList.videos.length,
                    itemBuilder: (context, index) {
                      VideoItem videoItem = _videosList.videos[index];
                      return InkWell(
                        onTap: ()async{
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return VideoPlayerScreen(
                              videoItem: videoItem,
                            );
                          }),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(20.0),
                            child:Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: videoItem.video.thumbnails.thumbnailsDefault.url,
                                ),
                                SizedBox(width: 20),
                                Flexible(child:Text(videoItem.video.title)),
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
