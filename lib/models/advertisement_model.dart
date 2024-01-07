// To parse this JSON data, do
//
//     final advertisement = advertisementFromJson(jsonString);


import 'dart:convert';

Advertisement advertisementFromJson(String str) => Advertisement.fromJson(json.decode(str));

String advertisementToJson(Advertisement data) => json.encode(data.toJson());

class Advertisement {
  Advertisement({
    required this.id,
    required this.description,
    required this.img,
    required this.phone,
    required this.whatsApp,
    required this.facebook,
    required this.telegram,
    required this.isText,
    required this.startDate,
    required this.endDate,
  });

  int id;
  String description;
  String img;
  String? phone;
  String? whatsApp;
  String? facebook;
  String? telegram;
  int? isText;
  DateTime startDate;
  DateTime endDate;

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
    id: json["id"],
    description: json["description"],
    img: json["img"],
    phone: json["phone"],
    whatsApp: json["whats_app"],
    facebook: json["facebook"],
    telegram: json["telegram"],
    isText: json["isText"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "img": img,
    "phone": phone,
    "whats_app": whatsApp,
    "facebook": facebook,
    "telegram": telegram,
    "isText": isText,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
  };
}
