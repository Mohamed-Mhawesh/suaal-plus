import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/user_sort_model.dart';
import 'package:suaal_plus/services/sort_services.dart';

import '../helpers/connectivity_check.dart';
import '../view/Components/no_internet_dialog.dart';

class SortController extends GetxController {
  bool isLoading = false;
  bool isConnected = false;
  final storage = const FlutterSecureStorage();
  String username = "";
  String userStudYear = "";
  String userAvatar = "";
  List<UserSort> fullSortList = [];
  List<UserSort> firstStudentsList = [];
  List<UserSort> otherStudentList = [];
  int currentUserSort = 0;
  int userCorrectQuestions = 0;
  String token = "";
  int userId = 0;

  getUserTokenAndIdAndName() async {
    String? value = (await storage.read(key: 'token'));
    String? value1 = (await storage.read(key: 'userId'));
    String? value2 = (await storage.read(key: 'username'));
    String? value3 = (await storage.read(key: 'study_year'));
    String? value4 = (await storage.read(key: 'avatar'));

    if (value != null) {
      token = value;
    }
    if (value1 != null) {
      userId = int.parse(value1);
    }
    if (value2 != null) {
      username = value2;
    }
    if (value3 != null) {
      switch (value3) {
        case "1":
          {
            userStudYear = "السنة الأولى";
          }
          break;
        case "2":
          {
            userStudYear = "السنة الثانية";
          }
          break;
        case "3":
          {
            userStudYear = "السنة الثالثة";
          }
          break;
        case "4":
          {
            userStudYear = "السنة الرابعة";
          }
          break;
        case "5":
          {
            userStudYear = "متخرج";
          }
          break;
        default:
          {
            userStudYear = "";
          }
      }
    }
    if (value4 != null) {
      userAvatar = value4;
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

  getSortDetails() async {
    isLoading = true;
    update();
    await getUserTokenAndIdAndName();
    try {
      var sortData = await SortServices.sortRequest(token);
      for (Map<String, dynamic> i in sortData) {
        fullSortList.add(UserSort.fromJson(i));
        update();
      }
      for (var i = 0; i < 3; i++) {
        firstStudentsList.add(fullSortList[i]);
      }
      for (var i = 3; i < fullSortList.length; i++) {
        otherStudentList.add(fullSortList[i]);
      }

      currentUserSort =
          fullSortList.indexWhere((element) => element.id == userId);
      userCorrectQuestions =
          fullSortList[currentUserSort].correctQuestions ?? 0;
      update();
    } finally {
      checkInternet();
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

  checkInternet() async {
    if (await ConnectivityCheck.checkConnect() == true) {
      isConnected = true;
      update();
    } else {
      isConnected = false;
      update();
    }
  }

  void noInternet(BuildContext context, Size size) {
    showNoInternetDialog(context, size);
  }

  Future<dynamic> showNoInternetDialog(BuildContext context, Size size) {
    return showDialog(
        context: context, builder: (context) => const NoInternetDialog());
  }

  @override
  void onInit() {
    checkInternet();
    getSortDetails();
    checkInternet();
    super.onInit();
  }
}
