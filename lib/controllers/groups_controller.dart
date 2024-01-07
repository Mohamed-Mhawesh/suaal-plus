import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/group_model.dart';
import 'package:suaal_plus/models/user_sort_model.dart';
import 'package:suaal_plus/services/group_services.dart';
import 'package:suaal_plus/view/Groups/group_quiz_screen.dart';
import 'package:worldtime/worldtime.dart';

import '../helpers/connectivity_check.dart';
import '../helpers/valid_input.dart';
import '../theme/constants.dart';
import '../view/Components/no_internet_dialog.dart';
import '../view/Components/rounded_input_field.dart';

class GroupsController extends GetxController {
  final storage = const FlutterSecureStorage();
  bool isLoading = false;
  bool membersIsLoading = false;
  bool isDoingFunction = false;
  bool isConnected = false;
  String token = "";
  String userId = "";
  List<Group> groupsByMeList = [];
  List<Group> fullGroupsByMeList = [];
  List<Group> myGroupsList = [];
  List<Group> fullMyGroupsList = [];
  List<Group> groupsList = [];
  List<Group> fullGroupsList = [];
  List<UserSort> groupMembersList = [];
  int chosenGroupsFilter = 1;
  bool isFirsButtonVisible = false;
  bool isSecondButtonVisible = true;
  String timeZone = "";
  DateTime dateTime = DateTime.now();
  TextEditingController groupPassword = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController editingController = TextEditingController();

  getUserToken() async {
    String? tokenValue = (await storage.read(key: 'token'));
    String? userIdValue = (await storage.read(key: 'userId'));
    if (tokenValue != null) {
      token = tokenValue;
      userId = userIdValue!;
    }
    update();
  }

  getRealDateTime() async {
    DateTime worldDateTime = await Worldtime().timeByCity(timeZone);

    dateTime = worldDateTime;
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

  void choose(String process, int chipId) {
    if (process == "gr") {
      chosenGroupsFilter = chipId;
      update();
    }
  }

  filterSearchResults(String query) {
    if (query.isNotEmpty) {
      groupsByMeList = fullGroupsByMeList
          .where((element) => element.subjects.contains(query))
          .toList();
      myGroupsList = fullMyGroupsList
          .where((element) => element.subjects.contains(query))
          .toList();
      groupsList = fullGroupsList
          .where((element) => element.subjects.contains(query))
          .toList();
      update();
    } else {
      groupsByMeList = fullGroupsByMeList;
      myGroupsList = fullMyGroupsList;
      groupsList = fullGroupsList;
      update();
    }
  }

  getChosenGroupList() {
    if (chosenGroupsFilter == 1) {
      return groupsByMeList;
    } else if (chosenGroupsFilter == 2) {
      return myGroupsList;
    } else {
      return groupsList;
    }
  }

  getGroups() async {
    try {
      isLoading = true;
      groupsByMeList.clear();
      fullGroupsByMeList.clear();
      myGroupsList.clear();
      fullMyGroupsList.clear();
      groupsList.clear();
      fullGroupsList.clear();
      update();
      var groupsData = await GroupServices.getGroups(token, userId);
      for (Map<String, dynamic> i in groupsData[0]) {
        groupsByMeList.add(Group.fromJson(i));
      }
      for (Map<String, dynamic> i in groupsData[0]) {
        fullGroupsByMeList.add(Group.fromJson(i));
      }
      for (Map<String, dynamic> i in groupsData[1]) {
        myGroupsList.add(Group.fromJson(i));
      }
      for (Map<String, dynamic> i in groupsData[1]) {
        fullMyGroupsList.add(Group.fromJson(i));
      }
      for (Map<String, dynamic> i in groupsData[2]) {
        groupsList.add(Group.fromJson(i));
      }
      for (Map<String, dynamic> i in groupsData[2]) {
        fullGroupsList.add(Group.fromJson(i));
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  getGroupMembers(int groupId) async {
    try {
      groupMembersList.clear();
      membersIsLoading = true;
      update();
      var membersData = await GroupServices.getGroupMembers(token, groupId);
      for (Map<String, dynamic> i in membersData) {
        groupMembersList.add(UserSort.fromJson(i));
      }
    } catch (e) {
      print(e);
    } finally {
      membersIsLoading = false;
      update();
    }
  }

  getFirsButtonVisibility(int groupId, DateTime startTime) {
    if (myGroupsList.any((element) => element.groupId == groupId) ||
        groupsByMeList.any((element) => element.groupId == groupId)) {
      getRealDateTime();
      if (dateTime.isAfter(startTime)) {
        return true;
      } else {
        return false;
      }
    } else if (groupsList.any((element) => element.groupId == groupId)) {
      return true;
    } else {
      return false;
    }
  }

  getSecondButtonVisibility(int groupId) {
    if (groupsByMeList.any((element) => element.groupId == groupId)) {
      return true;
    } else if (groupsList.any((element) => element.groupId == groupId)) {
      return false;
    } else {
      return true;
    }
  }

  getFirstButtonFunction(
      int groupId, int roundId, String groupName, BuildContext context) {
    if (myGroupsList.any((element) => element.groupId == groupId) ||
        groupsByMeList.any((element) => element.groupId == groupId)) {
      return startGroupQuiz(roundId, groupName);
    } else {
      return joinGroup(groupId, context);
    }
  }

  getSecondButtonFunction(int groupId) {
    if (groupsByMeList.any((element) => element.groupId == groupId)) {
      return deleteGroup(groupId);
    } else if (myGroupsList.any((element) => element.groupId == groupId)) {
      return leaveGroup(groupId);
    }
  }

  getFirstButtonText(int groupId) {
    if (myGroupsList.any((element) => element.groupId == groupId) ||
        groupsByMeList.any((element) => element.groupId == groupId)) {
      return "بدء";
    } else {
      return "انضم";
    }
  }

  getSecondButtonText(int groupId) {
    if (groupsByMeList.any((element) => element.groupId == groupId)) {
      return "حذف";
    } else if (myGroupsList.any((element) => element.groupId == groupId)) {
      return "مغادرة";
    } else {
      return "";
    }
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

  joinGroup(int groupId, BuildContext context) async {
    Group group =
        groupsList.firstWhere((element) => element.groupId == groupId);
    if (group.type == "private") {
      Get.defaultDialog(
        title: group.groupName,
        middleText: "",
        content: SizedBox(
          width: 300.w,
          child: Center(
            child: Form(
              key: formState,
              child: Column(
                children: [
                  RoundedInputField(
                      hintText: "كلمة مرور المجموعة",
                      icon: Icons.password,
                      onChanged: (value) {},
                      kbType: TextInputType.visiblePassword,
                      valid: (val) {
                        return validGroupPasswordInput(val!);
                      },
                      controller: groupPassword),
                  InkWell(
                    onTap: () async {
                      var formData = formState.currentState!;
                      if (formData.validate()) {
                        try {
                          isDoingFunction = true;
                          update();
                          var joinGroupData = await GroupServices.joinGroup(
                              token, userId, groupId, groupPassword.text);
                          if (joinGroupData == "password error") {
                            showGetSnackBar(
                                type: "warning", title: "كلمة المرور خاطئة");
                            isDoingFunction = false;
                            update();
                          } else if (joinGroupData == "success") {
                            isDoingFunction = false;
                            update();
                            Get.back();
                            showGetSnackBar(
                                type: "success",
                                title: "تم الانضمام إلى المجموعة بنجاح");
                            await getGroups();
                          } else {
                            isDoingFunction = false;
                            update();
                            showGetSnackBar(
                                type: "warning",
                                title: "حدثت مشكلة، حاول مجددًا من فضلك");
                          }
                        } catch (e) {
                          print(e);
                        } finally {
                          groupPassword.clear();
                        }
                      }
                    },
                    child: Container(
                      width: 72.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2.w, color: kSecondColor.withOpacity(0.1)),
                        color: kSecondColor.withOpacity(0.8),
                      ),
                      child: Center(
                        child: Text(
                          "انضم",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      groupPassword.clear();
      try {
        isDoingFunction = true;
        update();
        var joinGroupData = await GroupServices.joinGroup(
            token, userId, groupId, groupPassword.text);
        if (joinGroupData == "success") {
          isDoingFunction = false;
          update();
          showGetSnackBar(
              type: "success", title: "تم الانضمام إلى المجموعة بنجاح");
          await getGroups();
        } else {
          showGetSnackBar(
              type: "warning", title: "حدثت مشكلة، حاول مجددًا من فضلك");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  leaveGroup(int groupId) async {
    try {
      isDoingFunction = true;
      update();
      var leaveGroupData =
          await GroupServices.leaveGroup(token, userId, groupId);
    } catch (e) {
      print(e);
    } finally {
      isDoingFunction = false;
      update();
      await getGroups();
    }
  }

  deleteGroup(int groupId) async {
    try {
      isDoingFunction = true;
      update();

      var leaveGroupData =
          await GroupServices.deleteGroup(token, userId, groupId);
    } catch (e) {
      print(e);
    } finally {
      isDoingFunction = false;
      update();
      await getGroups();
    }
  }

  startGroupQuiz(int roundId, String groupName) async {
    await storage.write(key: "round_id", value: roundId.toString());
    await storage.write(key: "group_name", value: groupName);
    Get.to(() => GroupQuizScreen());
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
    await getUserToken();
    await getTimeZone();
    await getGroups();
    await getRealDateTime();
    super.onInit();
  }

  @override
  void dispose() {
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
