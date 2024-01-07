import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class UniversityServices {
  static Future universityRequest() async {
    try {
      var response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}/university'), headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        var universityObject = jsonDecode(response.body);
        var universityData = universityObject["university"];
        return universityData;
      } else {
        print("University failed ${response.statusCode}");
      }
    } catch (e) {
      print("University request Error: ${e.toString()}");
    }
  }
}
