// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
  required  this.message,
  required  this.token,
  required  this.userId,
  required  this.firstName,
  required  this.avatar,
  required  this.lastName,
  required  this.username,
  required  this.phone,
  required  this.country,
  required  this.city,
  required  this.role,
  required  this.graduated,
  required  this.universityId,
  required  this.studyYear,
  required  this.learningType,
  required  this.status,
    this.answeredQuestions,
    this.correctQuestions,
  });

  String? message;
  String? token;
  int? userId;
  String? firstName;
  String? lastName;
  String? avatar;
  String? username;
  String? phone;
  String? country;
  String? city;
  String? role;
  int? graduated;
  int? universityId;
  int? studyYear;
  String? learningType;
  String? status;
  String? answeredQuestions;
  String? correctQuestions;

  factory User.fromJson(Map<String, dynamic> json) => User(
    message: json["message"],
    token: json["token"],
    userId: json["userId"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
    username: json["username"],
    phone: json["phone"],
    country: json["country"],
    city: json["city"],
    role: json["role"],
    graduated: json["graduated"],
    universityId: json["university_id"],
    studyYear: json["study_year"],
    learningType: json["learning_type"],
    status: json["status"],
    answeredQuestions: json["answered_questions"],
    correctQuestions: json["correct_questions"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "userId": userId,
    "first_name": firstName,
    "last_name": lastName,
    "avatar":avatar,
    "username": username,
    "phone": phone,
    "country": country,
    "city":city,
    "role": role,
    "graduated": graduated,
    "university_id": universityId,
    "study_year": studyYear,
    "learning_type": learningType,
    "status": status,
    "answered_questions": answeredQuestions,
    "correct_questions": correctQuestions,
  };
}
