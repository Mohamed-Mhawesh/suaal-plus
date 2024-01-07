// To parse this JSON data, do
//
//     final home = homeFromJson(jsonString);


import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  Home({
    required this.advertisement,
    required this.topTen,
    required this.subject,
  });

  List<dynamic> advertisement;
  List<TopTen> topTen;
  List<Subject> subject;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    advertisement: List<dynamic>.from(json["advertisement"].map((x) => x)),
    topTen: List<TopTen>.from(json["topTen"].map((x) => TopTen.fromJson(x))),
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "advertisement": List<dynamic>.from(advertisement.map((x) => x)),
    "topTen": List<dynamic>.from(topTen.map((x) => x.toJson())),
    "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
  };
}

class Subject {
  Subject({
    required this.id,
    required this.subjectName,
    required this.year,
    required this.universityName,
    required this.specializeName,
  });

  int? id;
  String subjectName;
  String year;
  String universityName;
  String specializeName;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    subjectName: json["subject_name"],
    year: json["year"],
    universityName: json["university_name"],
    specializeName: json["specialize_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_name": subjectName,
    "year": year,
    "university_name": universityName,
    "specialize_name": specializeName,
  };
}

class TopTen {
  TopTen({
    required this.id,
    required this.firstName,
    required this.lastName,
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

  int? id;
  String? firstName;
  String? lastName;
  dynamic? username;
  String? email;
  dynamic? emailVerifiedAt;
  String? phone;
  String? password;
  String? country;
  String? city;
  int? studyYear;
  String? learningType;
  int? universityId;
  int? graduated;
  dynamic? carrer;
  int? answeredQuestions;
  int? correctQuestions;
  String? status;
  String? role;
  dynamic? rememberToken;
  dynamic? createdAt;
  dynamic? updatedAt;

  factory TopTen.fromJson(Map<String, dynamic> json) => TopTen(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    password: json["password"],
    country: json["country"],
    city: json["city"],
    studyYear: json["study_year"],
    learningType: json["learning_type"],
    universityId: json["university_id"],
    graduated: json["graduated"],
    carrer: json["carrer"],
    answeredQuestions: json["answered_questions"],
    correctQuestions: json["correct_questions"],
    status: json["status"],
    role: json["role"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
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
