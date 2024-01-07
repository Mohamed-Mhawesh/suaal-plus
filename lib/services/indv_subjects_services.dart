import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class IndividuallySubjectsServices {
  static Future individuallyRequest(String userToken, int universityId) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/individual'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      }, body: {
        'university': universityId.toString()
      });

      if (response.statusCode == 200) {
        var individuallySubjectsObject = jsonDecode(response.body);
        var individuallySubjectsData = individuallySubjectsObject["subjects"];

        return individuallySubjectsData;
      } else {
        print("Individually subjects failed ${response.statusCode}");
      }
    } catch (e) {
      print("Individually subjects request Error: ${e.toString()}");
    }
  }
}
