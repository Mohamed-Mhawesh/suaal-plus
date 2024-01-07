// To parse this JSON data, do
//
//     final coupon = couponFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Coupon couponFromJson(String str) => Coupon.fromJson(json.decode(str));

String couponToJson(Coupon data) => json.encode(data.toJson());

class Coupon {
  Coupon({
    required this.id,
    required this.title,
    required this.description,
    required this.companyId,
    required this.companyName,
    required this.logo,
    required this.phone,
    required this.whatsApp,
    required this.facebook,
    required this.telegram,
  });

  int id;
  String title;
  String description;
  int companyId;
  String companyName;
  String logo;
  String? phone;
  String? whatsApp;
  String? facebook;
  String? telegram;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["copon_id"],
    title: json["title"],
    description: json["description"],
    companyId: json["company_id"],
    companyName: json["company_name"],
    logo: json["logo"],
    phone: json["phone"],
    whatsApp: json["whats_app"],
    facebook: json["facebook"],
    telegram: json["telegram"],
  );

  Map<String, dynamic> toJson() => {
    "copon_id": id,
    "title":title,
    "description": description,
    "company_id":companyId,
    "company_name":companyName,
    "logo": logo,
    "phone": phone,
    "whats_app": whatsApp,
    "facebook": facebook,
    "telegram": telegram,
  };
}
