// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

List<PostResponse> postResponseFromJson(String str) => List<PostResponse>.from(json.decode(str).map((x) => PostResponse.fromJson(x)));

String postResponseToJson(List<PostResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostResponse {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  PostResponse({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}
