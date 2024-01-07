// To parse this JSON data, do
//
//     final avatar = avatarFromJson(jsonString);


import 'dart:convert';

Avatar avatarFromJson(String str) => Avatar.fromJson(json.decode(str));

String avatarToJson(Avatar data) => json.encode(data.toJson());

class Avatar {
  Avatar({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
