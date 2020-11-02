import 'dart:io';
import 'package:faith_pad_test/models/channel_info.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'package:faith_pad_test/models/videos_list.dart';

class Services{
  //
  //  static const CHANNEL_ID = 'UCfmySLZRhug4Hf1kE9zTauw';
  //  static const CHANNEL_ID = 'UCH5U89kvHrVxxS80xpoOydw';
  static const CHANNEL_ID = 'UCyoqIWgyiQmxYiNP_l7KlyQ';
  static const _baseUrl = 'www.googleapis.com';

  /*
  curl command: No curl Command for my browser.
   */

  static Future<ChannelInfo> getChannelInfo() async{
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers ={
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );

    http.Response response = await http.get(uri, headers: headers);
    print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<VideosList> getVideosList({String playListId, String pageToken}) async{
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers ={
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    http.Response response = await http.get(uri, headers: headers);
    print(response.body);
    VideosList videoList = videosListFromJson(response.body);
    return videoList;
  }
}