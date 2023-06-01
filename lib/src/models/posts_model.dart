// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

List<PostResponse> postResponseFromJson(String str) => List<PostResponse>.from(
    json.decode(str).map((x) => PostResponse.fromJson(x)));

String postResponseToJson(List<PostResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostResponse {
  PostResponse({
    
    required this.id,
    required this.title,
    required this.body,
  });

 
  int id;
  String title;
  String body;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
   
        "id": id,
        "title": title,
        "body": body,
      };
}
