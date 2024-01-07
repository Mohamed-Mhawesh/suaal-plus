import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class GroupServices {
  static Future createGroup(userToken, userId, name, subjects, questionsNum,
      type, password, isInGroup, fromTime, toTime) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/createGroup'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      }, body: {
        'name': name,
        'admin_id': userId,
        'subject': subjects,
        'questions_num': questionsNum,
        'type': type,
        'password': password,
        'is_in_group': isInGroup,
        'from_time': fromTime,
        'to_time': toTime,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var createGroupObject = jsonDecode(response.body);
        return createGroupObject;
      } else {
        print("createGroup failed ${response.statusCode}");
      }
    } catch (e) {
      print("createGroup request Error: ${e.toString()}");
    }
  }

  static Future getGroups(userToken, userId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/allGroups"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var groupsData = jsonDecode(response.body);

        var groupsByMe = groupsData['groupsByMe'];
        var myGroup = groupsData['myGroup'];
        var groups = groupsData['group'];
        return [groupsByMe, myGroup, groups];
      } else {
        (print("getGroupsRequest error ${response.statusCode}"));
      }
    } catch (e) {
      print("getGroupsRequest Error: $e");
    }
  }

  static Future getGroupMembers(userToken, groupId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/groupMembers"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'group_id': groupId.toString(),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var groupMembersData = jsonDecode(response.body);

        var groupMembers = groupMembersData['members'];

        return groupMembers;
      } else {
        (print("groupMembers error ${response.statusCode}"));
      }
    } catch (e) {
      print("groupMembersRequest Error: $e");
    }
  }

  static Future subjectsRequest(String userToken) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/availableSubjects'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
      );

      if (response.statusCode == 200) {
        var subjectsObject = jsonDecode(response.body);
        var subjectsData = subjectsObject["subjects"];

        return subjectsData;
      } else {
        print("subjects failed ${response.statusCode}");
      }
    } catch (e) {
      print("subjects request Error: ${e.toString()}");
    }
  }

  static Future getQuestionsNumber(userToken, subjects) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/allQuestionsNum"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'subject': subjects.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var questionsNumber = data["num"];

        return questionsNumber;
      } else {
        (print("getQuestionsNumberRequest error ${response.statusCode}"));
      }
    } catch (e) {
      print("getQuestionsNumberRequest Error: $e");
    }
  }

  static Future joinGroup(userToken, userId, groupId, groupPassword) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/joinGroup"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'group_id': groupId.toString(),
          'user_id': userId.toString(),
          'password': groupPassword.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        var responseMessage = data["message"];

        return responseMessage;
      } else {
        (print("joinGroup error ${response.statusCode}"));
      }
    } catch (e) {
      print("joinGroupRequest Error: $e");
    }
  }

  static Future leaveGroup(userToken, userId, groupId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/exitGroup"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'group_id': groupId.toString(),
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var responseMessage = data["message"];

        return responseMessage;
      } else {
        (print("leaveGroup error ${response.statusCode}"));
      }
    } catch (e) {
      print("leaveGroupRequest Error: $e");
    }
  }

  static Future deleteGroup(userToken, userId, groupId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/deleteGroup"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'group_id': groupId.toString(),
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var responseMessage = data["message"];
        return responseMessage;
      } else {
        (print("deleteGroup error ${response.statusCode}"));
      }
    } catch (e) {
      print("deleteGroupRequest Error: $e");
    }
  }

  static Future checkGroupName(groupName) async {
    try {
      var response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}/checkGroupName'),
          body: {'name': groupName});

      if (response.statusCode == 200) {
        var checkResult = jsonDecode(response.body)['message'];
        return checkResult.toString();
      } else {
        print("checkGroupName failed ${response.statusCode}");
      }
    } catch (e) {
      print("checkGroupName request Error: ${e.toString()}");
    }
  }

  static Future getQuestionsRequest(
    userToken,
    userId,
    roundId,
  ) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/startRound"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: {
          'round': roundId.toString(),
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var questions = data["question"];
        var endTime = data["end_time"];
        var answers = data["answer"];
        return [questions, answers, endTime];
      } else {
        (print("group quiz error response ${response.statusCode}"));
      }
    } catch (e) {
      print("group quiz Request Error: $e");
    }
  }

  static Future sendGroupResult(
      token, correctQuestions, questions, String? userId, round) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/groupResult"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'questions': questions.toString(),
          'correctQuestions': correctQuestions.toString(),
          'user': userId.toString(),
          'round': round.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        print("result req error ${response.statusCode}");
      }
    } catch (e) {
      print("quizResultRequest Error: $e");
    }
  }

  static Future getGroupResult(userToken, roundId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/roundHistory"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'round_id': roundId.toString(),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var groupResultData = jsonDecode(response.body);
        var groupHistory = groupResultData['history'];
        var groupInfo = groupResultData['groupInfo'];
        return [groupHistory, groupInfo];
      } else {
        (print("getGroupResult error ${response.statusCode}"));
      }
    } catch (e) {
      print("getGroupResultRequest Error: $e");
    }
  }

  static Future getTimeZone() async {
    try {
      var response =
          await http.get(Uri.parse('${ApiConstants.baseUrl}/timezone'));

      if (response.statusCode == 200) {
        var stringObject = response.body;
        var zone = jsonDecode(stringObject)["zone"];
        return zone;
      } else {
        print("zone failed ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
