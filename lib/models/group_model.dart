import 'dart:convert';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  int groupId;
  String groupName;
  String subjects;
  int usersNum;
  int? roundId;
  int adminId;
  String? username;
  String firstName;
  String lastName;
  int questionsNum;
  String type;
  String? password;
  DateTime fromTime;
  DateTime toTime;

  Group({
    required this.groupId,
    required this.groupName,
    required this.subjects,
    required this.usersNum,
    required this.roundId,
    required this.adminId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.questionsNum,
    required this.type,
    required this.password,
    required this.fromTime,
    required this.toTime,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    groupId: json["group_id"],
    groupName: json["group_name"],
    subjects: json["subjects"],
    usersNum: json["users_num"],
    roundId: json["round_id"],
    adminId: json["admin_id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    questionsNum: json["questions_num"],
    type: json["type"],
    password: json["password"],
    fromTime: DateTime.parse(json["from_time"]),
    toTime: DateTime.parse(json["to_time"]),
  );

  Map<String, dynamic> toJson() => {
    "group_id": groupId,
    "group_name": groupName,
    "subjects": subjects,
    "users_num": usersNum,
    "round_id": roundId,
    "admin_id": adminId,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "questions_num": questionsNum,
    "type": type,
    "password": password,
    "from_time": fromTime.toIso8601String(),
    "to_time": toTime.toIso8601String(),
  };
}