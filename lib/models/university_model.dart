// To parse this JSON data, do
//
//     final university = universityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

University universityFromJson(String str) => University.fromJson(json.decode(str));

String universityToJson(University data) => json.encode(data.toJson());

class University {
  University({
    required this.id,
    required this.name,
    required this.learningType,
  });

  int id;
  String name;
  String learningType;

  factory University.fromJson(Map<String, dynamic> json) => University(
    id: json["id"],
    name: json["name"],
    learningType: json["learning_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "learning_type": learningType,
  };
}
