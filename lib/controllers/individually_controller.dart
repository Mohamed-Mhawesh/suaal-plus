import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/services/indv_subjects_services.dart';

import '../helpers/connectivity_check.dart';
import '../models/subject_model.dart';
import '../view/Components/no_internet_dialog.dart';

class IndividuallyController extends GetxController {
  final storage = const FlutterSecureStorage();
  List recentUsed = [];
  Subject recentSubject = Subject(
      id: 0,
      subjectName: "subjectName",
      year: "1",
      universityName: "universityName",
      specializeName: "specializeName",
      specializeId: 0);
  bool isLoading = false;
  bool isConnected = false;
  String token = "";
  int userUniversity = 0;
  String chosenSpecialize = "الكل";
  List<Subject> subjectsList = []; //all subjects that comes from response
  List<Subject> activeSubjectList = []; //filtering subjects
  void chooseSpecialize(String chipId) {
    switch (chipId) {
      case "الكل":
        {
          chosenSpecialize = "الكل";
          update();
        }
        break;
      case "مدني":
        {
          chosenSpecialize = "مدني";
          update();
        }
        break;
      case "جزائي":
        {
          chosenSpecialize = "جزائي";
          update();
        }
        break;
      case "دولي":
        {
          chosenSpecialize = "دولي";
          update();
        }
        break;
      case "إداري":
        {
          chosenSpecialize = "إداري";
          update();
        }
        break;
      case "تجاري":
        {
          chosenSpecialize = "تجاري";
          update();
        }
        break;
      case "احوال شخصية ":
        {
          chosenSpecialize = "احوال شخصية ";
          update();
        }
        break;
      case "اضافي":
        {
          chosenSpecialize = "اضافي";
          update();
        }
        break;
      default:
        {
          chosenSpecialize = "الكل";
          update();
        }
    }
  }

  Color chosenColor(String chipId) {
    if (chosenSpecialize == chipId) {
      return kPrimaryColor;
    } else {
      return Colors.white;
    }
  }

  Color chosenTextColor(String chipId) {
    if (chosenSpecialize == chipId) {
      return Colors.white;
    } else {
      return kPrimaryColor;
    }
  }

  specializeColor(id) {
    switch (id) {
      case "مدني":
        {
          return [const Color(0xffb8b9ff), const Color(0xffb8b9ff)];
        }
      case "جزائي":
        {
          return [const Color(0xfff2f5ff), const Color(0xfff2f5ff)];
        }
      case "دولي":
        {
          return [const Color(0xff55d6c2), const Color(0xff55d6c2)];
        }
      case "إداري":
        {
          return [const Color(0xff9bf6ff), const Color(0xff9bf6ff)];
        }
      case "تجاري":
        {
          return [const Color(0xfffdffb6), const Color(0xfffdffb6)];
        }
      case "احوال شخصية ":
        {
          return [const Color(0xffcaffbf), const Color(0xffcaffbf)];
        }

      case "اضافي":
        {
          return [
            const Color(0xffc7eafd),
            const Color(0xffc7eafd).withOpacity(0.9)
          ];
        }

      default:
        {
          return [
            const Color(0xffadf7b1),
            const Color(0xffadf7b1).withOpacity(0.9)
          ];
        }
    }
  }

  specializeIcon(id) {
    switch (id) {
      case "مدني":
        {
          return "s1.png";
        }

      case "جزائي":
        {
          return "s2.png";
        }

      case "دولي":
        {
          return "s3.png";
        }

      case "إداري":
        {
          return "s4.png";
        }

      case "تجاري":
        {
          return "s5.png";
        }

      case "احوال شخصية ":
        {
          return "s6.png";
        }

      case "اضافي":
        {
          return "s7.png";
        }

      default:
        {
          return "s1.png";
        }
    }
  }

  chosenShadowColor(id) {
    switch (id) {
      case "مدني":
        {
          return const Color(0xffa4f5a6);
        }

      case "جزائي":
        {
          return const Color(0xfffdfca4);
        }

      case "دولي":
        {
          return const Color(0xffe6b7ff);
        }

      case "إداري":
        {
          return const Color(0xffffb5b8);
        }

      case "تجاري":
        {
          return const Color(0xff99f6fd);
        }

      case "احوال شخصية ":
        {
          return const Color(0xffffe2fe);
        }

      case "اضافي":
        {
          return const Color(0xff9bf5fd);
        }

      default:
        {
          return const Color(0xffadf7b1);
        }
    }
  }

  getRecent() async {
    String? value1 = (await storage.read(key: 'recent1'));
    if (value1 != null) {
      for (var i in subjectsList) {
        if (i.id.toString() == value1) {
          recentSubject = i;
        }
      }
    }
  }

  filterSubjects(String specialize) {
    activeSubjectList.clear();
    if (specialize == "الكل") {
      activeSubjectList.addAll(subjectsList);
      update();
    }

    {
      activeSubjectList.addAll(subjectsList
          .where((element) => element.specializeName == specialize));
      update();
    }
  }

  setIndvSubId(subId, subName, subYear) async {
    await storage.write(key: 'individuallySubId', value: subId.toString());
    await storage.write(key: 'individuallySubName', value: subName.toString());
    await storage.write(key: 'individuallySubYear', value: subYear.toString());

    update();
  }

  setRecentSubjects(subId) async {
    await storage.write(key: 'recent1', value: subId.toString());

    getRecent();

    update();
  }

  getUserToken() async {
    String? value = (await storage.read(key: 'token'));
    String? value1 = (await storage.read(key: 'university_id'));

    if (value != null) {
      token = value;
    }
    if (value1 != null) {
      userUniversity = int.parse(value1);
    }
    update();
  }

  String subjectYear(int year) {
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

  getIndividuallyData() async {
    isLoading = true;
    update();
    await getUserToken();
    try {
      var individuallyData =
          await IndividuallySubjectsServices.individuallyRequest(
              token, userUniversity);
      for (Map<String, dynamic> i in individuallyData) {
        subjectsList.add(Subject.fromJson(i));
      }

      activeSubjectList.addAll(subjectsList);
      await getRecent();
    } catch (e) {
      print("Individually Error $e");
    } finally {
      checkInternet();
      isLoading = false;
      update();
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
  void onInit() async {
    checkInternet();
    getIndividuallyData();
    checkInternet();

    super.onInit();
  }
}
