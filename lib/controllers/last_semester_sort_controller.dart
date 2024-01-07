import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/services/sort_services.dart';

import '../models/user_sort_model.dart';

class LastSemesterSortController extends GetxController {
  bool isLoading = false;
  bool noPreviousSemester = false;
  final storage = const FlutterSecureStorage();
  String token = "";
  int userId = 0;
  List<UserSort> lastSemesterSortList = [];

  getUserTokenAndId() async {
    String? value = (await storage.read(key: 'token'));
    String? value1 = (await storage.read(key: 'userId'));

    if (value != null) {
      token = value;
    }
    if (value1 != null) {
      userId = int.parse(value1);
    }

    update();
  }

  getUserStudyYear(year) {
    switch (year) {
      case 1:
        {
          return "السنة الأولى";
        }
      case 2:
        {
          return "السنة الثانية";
        }
      case 3:
        {
          return "السنة الثالثة";
        }
      case 4:
        {
          return "السنة الرابعة";
        }
      case 5:
        {
          return "متخرج";
        }
      default:
        {
          return "";
        }
    }
  }

  getLastSemesterSort() async {
    try {
      isLoading = true;
      update();
      var lastSemesterSortData =
          await SortServices.lastSemesterSortRequest(token);
      if (lastSemesterSortData[0] == "success") {
        for (Map<String, dynamic> i in lastSemesterSortData[1]) {
          lastSemesterSortList.add(UserSort.fromJson(i));
          update();
        }
      }
      if (lastSemesterSortData[0] == "no previous semester") {
        noPreviousSemester = true;
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  Widget getSortIcon(Size size, int index) {
    if (index == 1) {
      return SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.04,
        child: Image.asset("assets/icons/crown.png"),
      );
    } else if (index == 2) {
      return SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.04,
        child: Image.asset("assets/icons/second.png"),
      );
    } else if (index == 3) {
      return SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.04,
        child: Image.asset("assets/icons/third.png"),
      );
    } else if (index <= 10) {
      return SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.04,
        child: Image.asset("assets/icons/top_ten.png"),
      );
    } else {
      return SizedBox(
        width: size.width * 0.1,
        height: size.height * 0.04,
        child: Image.asset("assets/icons/star.png"),
      );
    }
  }

  @override
  void onInit() async {
    await getUserTokenAndId();
    getLastSemesterSort();

    super.onInit();
  }
}
