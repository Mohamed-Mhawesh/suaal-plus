import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class EditServices {

  static Future editProfileRequest(
      userToken,
      userId,
      username,
      firstname,
      lastname,
      newPassword,
      country,
      city,
      universityID,
      graduated,
      studyYear,
      learningType,
      avatar) async {
    try {
      var response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/editProfile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: {
          'user_id': userId,
          "avatar": avatar,
          'username':username,
          'first_name': firstname,
          'last_name': lastname,
          'password': newPassword,
          'country': country,
          'city': city,
          'university': universityID,
          'graduated': graduated,
          'study_year': studyYear,
          'learning_type': learningType,
        },
      );

      if (response.statusCode == 200) {
        var editResponse = jsonDecode(response.body)["message"];
        return editResponse;
      } else {
        print("edit failed ${response.statusCode}");
      }
    } catch (e) {
      print("edit request Error: ${e.toString()}");
    }
  }

  static Future avatar() async {
    try {
      var response =
          await http.get(Uri.parse('${ApiConstants.baseUrl}/avatar'));

      if (response.statusCode == 200) {
        var stringObject = response.body;
        var avatars = jsonDecode(stringObject)["avatar"];
        return avatars;
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
