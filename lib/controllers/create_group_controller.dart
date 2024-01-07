import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/checkbox_state.dart';
import 'package:suaal_plus/models/subject_model.dart';
import 'package:suaal_plus/services/group_services.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import 'package:worldtime/worldtime.dart';

import '../models/university_model.dart';
import '../theme/constants.dart';

class CreateGroupController extends GetxController {
  final storage = const FlutterSecureStorage();
  String token = "";
  String userId = "";
  bool isLoading = false;
  bool isQuestionsNumLoading = false;
  bool isCreatingGroup = false;

  TextEditingController groupName = TextEditingController();
  TextEditingController groupPassword = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  String groupNameCheckMessage = "";
  String learningType = "الكل";
  int universityID = 0;
  int studyYear = 1;
  int chosenLearningType = 5;
  bool isPrivate = false;
  String groupType = "public";
  bool isInGroup = true;
  int chosenIsInGroup = 1;
  int numOfQuestions = 0;
  List numbersOfQuestionsCanUsed = [];
  String questionsNumberDropdownValue = "10";
  String groupQuizSubjects = "";
  List<University> university = [];
  List<University> activeUniversity = [];
  List<CheckBoxState> availableSubjectsList = [];
  List<CheckBoxState> fullAvailableSubjectsList = [];
  List<CheckBoxState> filteredAvailableSubjectsList = [];

  TextEditingController editingController = TextEditingController();
  String timeZone = "";
  DateTime realDateTime = DateTime.now();
  DateTime dateTime = DateTime.now().add(const Duration(minutes: 10));
  TimeOfDay timeOfDay =
      TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);

  getRealDateTime() async {
    DateTime worldDateTime = await Worldtime().timeByCity(timeZone);
    realDateTime = worldDateTime;
    dateTime = realDateTime.add(const Duration(minutes: 10));
    update();
  }

  void choose(String process, int chipId) {
    if (process == "in") {
      if (chipId == 1) {
        isInGroup = true;
        chosenIsInGroup = 1;
      } else {
        isInGroup = false;
        chosenIsInGroup = 2;
      }
      update();
    }
    if (process == "le") {
      switch (chipId) {
        case 5:
          {
            learningType = "الكل";
            chosenLearningType = 5;
            universityID = 0;
            activeUniversity.clear();
            numbersOfQuestionsCanUsed.clear();

            update();
          }
          break;
        case 1:
          {
            learningType = "عام";
            chosenLearningType = 1;
            universityID = 0;
            activeUniversity.clear();
            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        case 2:
          {
            learningType = "خاص";
            universityID = 0;
            chosenLearningType = 2;
            activeUniversity.clear();

            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        case 3:
          {
            learningType = "افتراضي";
            universityID = 0;
            chosenLearningType = 3;
            activeUniversity.clear();

            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        case 4:
          {
            learningType = "مفتوح";
            universityID = 0;
            chosenLearningType = 4;
            activeUniversity.clear();

            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
            print(activeUniversity);
          }
          break;
        default:
          {
            learningType = "عام";
            universityID = 0;
            chosenLearningType = 1;
            activeUniversity.clear();

            numbersOfQuestionsCanUsed.clear();
            activeUniversity
                .add(University(id: 0, name: "الكل", learningType: "الكل"));
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
      }
    }
    if (process == "un") {
      for (var i in activeUniversity) {
        if (i.id == chipId) {
          universityID = i.id;
          update();
        }
      }
    }
  }

  filterSearchResults(String query) {
    if (query.isNotEmpty) {
      availableSubjectsList = fullAvailableSubjectsList
          .where((element) => element.name.contains(query))
          .toList();
      update();
    } else {
      availableSubjectsList = fullAvailableSubjectsList;
      update();
    }
  }

  checkGroupName(groupName) async {
    try {
      var res = await GroupServices.checkGroupName(groupName);

      groupNameCheckMessage = res.toString();
      update();
    } catch (e) {
      print(e);
    }
  }

  createGroup(BuildContext context) async {
    try {
      isCreatingGroup = true;
      update();
      DateTime currentWorldDateTime = await Worldtime().timeByCity(timeZone);
      var formData = formState.currentState!;
      if (formData.validate()) {
        if (groupQuizSubjects != "") {
          if (dateTime.difference(currentWorldDateTime).inMinutes >= 10) {
            isCreatingGroup = true;
            update();
            var createGroupData = await GroupServices.createGroup(
                token,
                userId,
                groupName.text,
                groupQuizSubjects,
                questionsNumberDropdownValue,
                groupType,
                groupPassword.text,
                isInGroup.toString(),
                dateTime.toString(),
                dateTime.add(const Duration(minutes: 50)).toString());
            Get.offAll(() => const HomePage());
          } else {
            showGetSnackBar(
                type: "warning",
                title: "يجب أن تبدأ المجموعة بعد 10 دقائق على الأقل");
          }
        } else {
          isCreatingGroup = false;
          update();
          showGetSnackBar(type: "warning", title: "لم تختر أي مادة");
        }
      } else {
        isCreatingGroup = false;
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isCreatingGroup = false;
      update();
    }
  }

  changeQuestionsNum(String num) {
    questionsNumberDropdownValue = num;
    update();
  }

  getQuestionsNum(String token) async {
    numbersOfQuestionsCanUsed.clear();
    try {
      isQuestionsNumLoading = true;
      update();
      var questionsNumData =
          await GroupServices.getQuestionsNumber(token, groupQuizSubjects);
      if (int.parse(questionsNumData) <= 50) {
        numOfQuestions = int.parse(questionsNumData);
      } else if (int.parse(questionsNumData) > 50) {
        numOfQuestions = 50;
      }

      for (var i = 0; i <= numOfQuestions; i = i + 10) {
        if (i != 0) {
          numbersOfQuestionsCanUsed.add("$i");
        }
      }
      update();
    } catch (e) {
      print(e);
    } finally {
      isQuestionsNumLoading = false;
      update();
    }
  }

  changeGroupQuizSubjects() {
    groupQuizSubjects = "";
    for (CheckBoxState i in availableSubjectsList) {
      if (i.value) {
        groupQuizSubjects += "${i.id},";
      }
    }
    update();
  }

  getUserToken() async {
    String? tokenValue = (await storage.read(key: 'token'));
    String? userIdValue = (await storage.read(key: 'userId'));
    if (tokenValue != null) {
      token = tokenValue;
      userId = userIdValue!;
    }
    update();
  }

  getTimeZone() async {
    try {
      var data = await GroupServices.getTimeZone();
      timeZone = data;
      update();
    } catch (e) {
      print(e);
    }
  }

  getAvailableSubjects() async {
    try {
      isLoading = true;
      update();

      var availableSubjectsData = await GroupServices.subjectsRequest(token);
      for (Map<String, dynamic> i in availableSubjectsData) {
        availableSubjectsList.add(CheckBoxState(
            id: Subject.fromJson(i).id,
            name: Subject.fromJson(i).subjectName ?? ""));
      }
      for (Map<String, dynamic> i in availableSubjectsData) {
        fullAvailableSubjectsList.add(CheckBoxState(
            id: Subject.fromJson(i).id,
            name: Subject.fromJson(i).subjectName ?? ""));
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  changeGroupType(bool value) {
    isPrivate = value;
    if (isPrivate) {
      groupType = "private";
    } else {
      groupType = "public";
    }
    print("groupType=$groupType");
    update();
  }

  @override
  void onInit() async {
    await getUserToken();
    await getTimeZone();
    await getAvailableSubjects();
    await getQuestionsNum(token);
    await getRealDateTime();

    super.onInit();
  }

  @override
  void dispose() {
    groupName.dispose();
    groupPassword.dispose();
    super.dispose();
  }
}

SnackbarController showGetSnackBar(
    {required String type, required String title}) {
  return Get.snackbar(
    "",
    "",
    titleText: Row(
      children: [
        Icon(
          type == "success" ? Icons.check_circle : Icons.warning_rounded,
          color: Colors.white,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          title,
          style: subjectNameTextStyle,
        ),
      ],
    ),
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    backgroundColor:
        type == "success" ? const Color(0xff55a630) : const Color(0xfffecf3e),
    colorText: Colors.white,
    messageText: const SizedBox(),
    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
  );
}
