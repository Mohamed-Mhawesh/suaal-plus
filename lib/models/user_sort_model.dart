// To parse this JSON data, do
//
//     final userSort = userSortFromJson(jsonString);


import 'dart:convert';

UserSort userSortFromJson(String str) => UserSort.fromJson(json.decode(str));

String userSortToJson(UserSort data) => json.encode(data.toJson());

class UserSort {
  UserSort({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.studyYear,
    required this.avatar,
    required this.username,
    required this.correctQuestions,
    required this.mark,
  });

  int? id;
  String? firstName;
  String? lastName;
  int? studyYear;
  String? avatar;
  String? username;
  int? correctQuestions;
  int? mark;

  factory UserSort.fromJson(Map<String, dynamic> json) => UserSort(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    studyYear:json["study_year"],
    avatar:json["avatar"],
    username: json["username"],
    correctQuestions: json["correct_questions"],
    mark: json["mark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "study_year":studyYear,
    "avatar":avatar,
    "username": username,
    "mark": mark,
  };
}
