import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class QuizServices {
  static Future individuallyRequest(userToken, subjectId, questionsNumber,
      learningType, universityId, yearTime) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/individualQuiz"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: {
          'subject': subjectId.toString(),
          'num': questionsNumber.toString(),
          'year_time': yearTime.toString(),
          'learning_type': learningType.toString(),
          'university': universityId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var questions = data["question"];
        var answers = data["answers"];

        return [questions, answers];
      } else {
        (print("quiz error ${response.statusCode}"));
      }
    } catch (e) {
      print("individuallyRequest Error: $e");
    }
  }

  static Future getQuestionsNumber(
      userToken, subjectId, yearTime, universityId, learningType) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/questionsNum"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',
          "Charset": "utf-8"
        },
        body: {
          'subject': subjectId.toString(),
          'year_time': yearTime.toString(),
          'learning_type': learningType.toString(),
          'university': universityId.toString()
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var questionsNumber = data["num"];

        return questionsNumber;
      } else {
        (print("quiz error ${response.statusCode}"));
      }
    } catch (e) {
      print("getQuestionsNumberRequest Error: $e");
    }
  }

  static Future quizResultRequest(
      token, correctQuestions, wrongQuestions, String? userId) async {
    try {
      var response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/quizResult"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'wrongQuestion': wrongQuestions.toString(),
          'correctQuestion': correctQuestions.toString(),
          'user_id': userId.toString(),
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

  static Future quizUniversityRequest(token) async {
    try {
      var response = await http.get(
          Uri.parse('${ApiConstants.baseUrl}/availableUniversities'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200) {
        var universityObject = jsonDecode(response.body);
        var universityData = universityObject["universities"];
        return universityData;
      } else {
        print("av University failed ${response.statusCode}");
      }
    } catch (e) {
      print("av University request Error: ${e.toString()}");
    }
  }

  static Future quizYearsRequest(
      token, universityId, learningType, subject) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/availableYears'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        "university": universityId.toString(),
        'learning_type': learningType,
        'subject': subject
      });

      if (response.statusCode == 200) {
        var universityObject = jsonDecode(response.body);
        var universityData = universityObject["years"];
        return universityData;
      } else {
        print("av years failed ${response.statusCode}");
      }
    } catch (e) {
      print("av years request Error: ${e.toString()}");
    }
  }
}
