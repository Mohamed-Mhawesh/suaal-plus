import 'dart:convert';

import 'package:suaal_plus/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:suaal_plus/services/api_constants.dart';

class AuthServices {
  static Future signup(
      username,
      phone,
      password,
      firstname,
      lastname,
      graduated,
      country,
      city,
      learningType,
      universityID,
      studyYear,
      avatar) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/createUser'), body: {
        'first_name': firstname,
        'last_name': lastname,
        'username': username,
        'password': password,
        'phone': phone,
        'country': country,
        'city': city,
        'graduated': graduated,
        'study_year': studyYear,
        'learning_type': learningType,
        'university_id': universityID,
        'avatar': avatar,
        'role': 'user'
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var stringObject = jsonDecode(response.body);

        return stringObject;
      } else {
        print("signUp failed ${response.statusCode}");
      }
    } catch (e) {
      print("request Error: ${e.toString()}");
    }
  }

  //to check if username exist on database or not
  static Future checkUsername(username) async {
    try {
      var response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}/checkUsername'),
          body: {'username': username});

      if (response.statusCode == 200) {
        var checkResult = jsonDecode(response.body)['message'];
        return checkResult.toString();
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print("check request Error: ${e.toString()}");
    }
  }

  static Future checkPhone(phone) async {
    try {
      var response = await http.post(
          Uri.parse('${ApiConstants.baseUrl}/checkPhone'),
          body: {'phone': phone});

      if (response.statusCode == 200) {
        var checkResult = jsonDecode(response.body)['message'];

        return checkResult.toString();
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print("check phone request Error: ${e.toString()}");
    }
  }

  static Future login(phone, password) async {
    try {
      var response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/login'),
        body: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var stringObject = response.body;
        var user = userFromJson(stringObject);
        return user;
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
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

  static Future otp(phone) async {
    try {
      var response = await http.post(Uri.parse('${ApiConstants.baseUrl}/otp'),
          body: {'phone': phone});

      if (response.statusCode == 200) {
        var stringObject = response.body;
        var otp = jsonDecode(stringObject)["verifyCode"];
        return otp;
      } else {
        print("otp failed ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future resetPassword(phone, password) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/resetPassword'), body: {
        'phone': phone,
        'password': password,
      });

      if (response.statusCode == 200) {
        var resetResult = jsonDecode(response.body)['message'];

        return resetResult.toString();
      } else {
        print("reset failed ${response.statusCode}");
      }
    } catch (e) {
      print("reset request Error: ${e.toString()}");
    }
  }

  static Future checkUpdate() async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/checkUpdate'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var checkUpdateObject = jsonDecode(response.body);

        return checkUpdateObject;
      } else {
        print("checkUpdate with error${response.statusCode}");
      }
    } catch (e) {
      print("checkUpdate request Error: ${e.toString()}");
    }
  }
}
