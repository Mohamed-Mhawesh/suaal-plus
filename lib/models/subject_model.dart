// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(Subject data) => json.encode(data.toJson());

class Subject {
  Subject({
    required this.id,
    required this.subjectName,
    required this.year,
    required this.universityName,
    required this.specializeId,
    required this.specializeName,
  });

  int id;
  String? subjectName;
  String? year;
  String? universityName;
  int? specializeId;
  String? specializeName;


  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    subjectName: json["subject_name"],
    year: json["year"],
    universityName: json["university_name"],
    specializeId: json["specialize_id"],
    specializeName: json["specialize_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_name": subjectName,
    "year": year,
    "university_name": universityName,
    "specialize_id" : specializeId,
    "specialize_name": specializeName,
  };
}
