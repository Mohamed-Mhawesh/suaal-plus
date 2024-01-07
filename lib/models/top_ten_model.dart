// To parse this JSON data, do
//
//     final topTen = topTenFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TopTen topTenFromJson(String str) => TopTen.fromJson(json.decode(str));

String topTenToJson(TopTen data) => json.encode(data.toJson());

class TopTen {
  TopTen({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.password,
    required this.country,
    required this.city,
    required this.studyYear,
    required this.learningType,
    required this.universityId,
    required this.graduated,
    required this.carrer,
    required this.answeredQuestions,
    required this.correctQuestions,
    required this.status,
    required this.role,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? password;
  String? country;
  String? city;
  int? studyYear;
  String? learningType;
  int? universityId;
  int? graduated;
  String? carrer;
  int? answeredQuestions;
  int? correctQuestions;
  String? status;
  String? role;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  factory TopTen.fromJson(Map<String, dynamic> json) => TopTen(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    avatar: json["avatar"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"]??"",
    phone: json["phone"],
    password: json["password"],
    country: json["country"],
    city: json["city"],
    studyYear: json["study_year"],
    learningType: json["learning_type"],
    universityId: json["university_id"],
    graduated: json["graduated"],
    carrer: json["carrer"]??"",
    answeredQuestions: json["answered_questions"],
    correctQuestions: json["correct_questions"],
    status: json["status"],
    role: json["role"],
    rememberToken: json["remember_token"]??"",
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "avatar":avatar,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "password": password,
    "country": country,
    "city": city,
    "study_year": studyYear,
    "learning_type": learningType,
    "university_id": universityId,
    "graduated": graduated,
    "carrer": carrer,
    "answered_questions": answeredQuestions,
    "correct_questions": correctQuestions,
    "status": status,
    "role": role,
    "remember_token": rememberToken,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
