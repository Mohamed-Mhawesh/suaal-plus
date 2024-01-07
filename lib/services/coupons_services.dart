import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class CouponsServices {
  static Future couponRequest(String userToken, String userId) async {
    try {
      var response = await http.post(Uri.parse('${ApiConstants.baseUrl}/copon'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken'
          },
          body: {
            'user_id': userId
          });

      if (response.statusCode == 200) {
        var couponObject = jsonDecode(response.body);

        var couponsData = couponObject["copons"];

        return couponsData;
      } else {
        print("failed ${response.statusCode}");
      }
    } catch (e) {
      print("coupons request Error: ${e.toString()}");
    }
  }

  static Future senCouponRequest(
      String userToken, String userId, String coupons) async {
    try {
      var response = await http
          .post(Uri.parse('${ApiConstants.baseUrl}/requestCopon'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken'
      }, body: {
        'user_id': userId,
        'copons': coupons,
      });

      if (response.statusCode == 200) {
        var couponObject = jsonDecode(response.body)["message"];

        return couponObject;
      } else {
        print("send couponsfailed ${response.statusCode}");
      }
    } catch (e) {
      print("sen coupons request Error: ${e.toString()}");
    }
  }
}
