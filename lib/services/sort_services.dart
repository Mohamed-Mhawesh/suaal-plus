import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class SortServices {
  static Future sortRequest(String userToken) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/elite'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
      );

      if (response.statusCode == 200) {
        var sortObject = jsonDecode(response.body);

        var sortData = sortObject["elite"];
        return sortData;
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print("sort request Error: ${e.toString()}");
    }
  }

  static Future lastSemesterSortRequest(String userToken) async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/lastSemester'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
      );
      if (response.statusCode == 200) {
        var lastSemesterSortObject = jsonDecode(response.body);
        var message = lastSemesterSortObject["message"];
        var lastSemesterSortData = lastSemesterSortObject["rank"];
        return [message, lastSemesterSortData];
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print("lastSemesterSort request Error: ${e.toString()}");
    }
  }
}
