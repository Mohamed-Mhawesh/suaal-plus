import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class HomeServices {
  static Future mainRequest(
      String userToken, String userId, int year, int universityId) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/HomeScreen'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      }, body: {
        "year": year.toString(),
        "user_id": userId,
        "university": universityId.toString()
      });
      if (response.statusCode == 200) {
        var homeObject = jsonDecode(response.body);

        var advertisement = homeObject["advertisement"];
        var topTen = homeObject["topTen"];
        var subjects = homeObject["subject"];
        var endSemester = homeObject["end_semester"];
        var notifications = homeObject["notifications"];
        var endIn = homeObject["end_in"];

        return [
          advertisement,
          topTen,
          subjects,
          endSemester,
          notifications,
          endIn
        ];
      } else {
        print("main request failed ${response.statusCode}");
      }
    } catch (e) {
      print("main request Error: ${e.toString()}");
    }
  }

  static Future inviteRequest(String userToken) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/invite'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
      );

      if (response.statusCode == 200) {
        var inviteObject = jsonDecode(response.body);
        var inviteData = inviteObject["link"];

        return inviteData;
      } else {
        print("invite failed ${response.statusCode}");
      }
    } catch (e) {
      print("invite request Error: ${e.toString()}");
    }
  }

  static Future privacyRequest() async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/privacyPolicy'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var privacyObject = jsonDecode(response.body);
        var privacyData = privacyObject["privacy"];

        return privacyData;
      } else {
        print("privacy failed ${response.statusCode}");
      }
    } catch (e) {
      print("privacy request Error: ${e.toString()}");
    }
  }

  static Future allNotifications(userToken, userId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/allNotifications"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var responseMessage = data["message"];
        var responseData = data["notification"];
        return [responseMessage, responseData];
      } else {
        (print("allNotifications error ${response.statusCode}"));
      }
    } catch (e) {
      print("allNotificationsRequest Error: $e");
    }
  }

  static Future seenNotifications(userToken, userId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/seenNotifications"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var responseMessage = data["message"];
        return responseMessage;
      } else {
        (print("seenNotifications error ${response.statusCode}"));
      }
    } catch (e) {
      print("seenNotificationsRequest Error: $e");
    }
  }

  static Future afterNinty(userToken, userId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/afterNinty"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'user_id': userId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var responseMessage = data["message"];
        return responseMessage;
      } else {
        (print("afterNinty error ${response.statusCode}"));
      }
    } catch (e) {
      print("afterNintyRequest Error: $e");
    }
  }
}
