// To parse this JSON data, do
//
//     final streamingInfo = streamingInfoFromJson(jsonString);

import 'dart:convert';

StreamingInfo streamingInfoFromJson(String str) => StreamingInfo.fromJson(json.decode(str));

String streamingInfoToJson(StreamingInfo data) => json.encode(data.toJson());

class StreamingInfo {
  StreamingInfo({
    this.kind,
    this.etag,
    this.regionCode,
    this.pageInfo,
    this.items,
  });

  String kind;
  String etag;
  String regionCode;
  PageInfo pageInfo;
  List<StreamingItem> items;

  factory StreamingInfo.fromJson(Map<String, dynamic> json) => StreamingInfo(
    kind: json["kind"],
    etag: json["etag"],
    regionCode: json["regionCode"],
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
    items: List<StreamingItem>.from(json["items"].map((x) => StreamingItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "regionCode": regionCode,
    "pageInfo": pageInfo.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class StreamingItem {
  StreamingItem({
    this.kind,
    this.etag,
    this.streaming_id,
  });

  String kind;
  String etag;
  StreamingId streaming_id;

  factory StreamingItem.fromJson(Map<String, dynamic> json) => StreamingItem(
    kind: json["kind"],
    etag: json["etag"],
    streaming_id: StreamingId.fromJson(json["id"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": streaming_id.toJson(),
  };
}

class StreamingId {
  StreamingId({
    this.kind,
    this.videoId,
  });

  String kind;
  String videoId;

  factory StreamingId.fromJson(Map<String, dynamic> json) => StreamingId(
    kind: json["kind"],
    videoId: json["videoId"],
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "videoId": videoId,
  };
}

class PageInfo {
  PageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json["totalResults"],
    resultsPerPage: json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "resultsPerPage": resultsPerPage,
  };
}
