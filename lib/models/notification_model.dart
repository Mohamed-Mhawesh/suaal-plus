import 'dart:convert';

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  int id;
  int userId;
  String title;
  String? description;
  int? roundId;
  int? semesterId;
  DateTime showTime;
  int hadSeen;
  DateTime? seenAt;
  DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.roundId,
    required this.semesterId,
    required this.showTime,
    required this.hadSeen,
    required this.seenAt,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    roundId: json["round_id"],
    semesterId:json["semester_id"],
    showTime: DateTime.parse(json["show_time"]),
    hadSeen: json["had_seen"],
    seenAt: DateTime.parse(json["seen_at"]??"0000-00-00 00:00:00"),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "round_id": roundId,
    "semester_id": semesterId,
    "show_time": showTime.toIso8601String(),
    "had_seen": hadSeen,
    "seen_at": seenAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}