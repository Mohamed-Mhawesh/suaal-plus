import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/group_model.dart';
import 'package:suaal_plus/models/notification_model.dart';
import 'package:suaal_plus/models/user_sort_model.dart';
import 'package:suaal_plus/services/home_services.dart';
import 'package:suaal_plus/view/Groups/group_result_screen.dart';

import '../services/group_services.dart';

class NotificationsController extends GetxController {
  final storage = const FlutterSecureStorage();
  bool isLoading = false;
  bool isLoadingResult = false;
  String token = "";
  String userId = "";
  String userAvatar = "";
  List<Notification> notificationsList = [];
  List<UserSort> usersSortList = [];
  Group groupInfo = Group(
      groupId: 2,
      groupName: "groupName",
      subjects: "subjects",
      usersNum: 0,
      roundId: 0,
      adminId: 0,
      username: "username",
      firstName: "firstName",
      lastName: "lastName",
      questionsNum: 0,
      type: "type",
      password: "password",
      fromTime: DateTime.now(),
      toTime: DateTime.now());

  getUserToken() async {
    String? tokenValue = (await storage.read(key: 'token'));
    String? userIdValue = (await storage.read(key: 'userId'));
    String? userAvatarValue = (await storage.read(key: 'avatar'));
    if (tokenValue != null) {
      token = tokenValue;
      userId = userIdValue!;
      userAvatar = userAvatarValue ?? "";
    }
    update();
  }

  getNotifications() async {
    isLoading = true;
    update();
    try {
      var notificationsData =
          await HomeServices.allNotifications(token, userId);
      if (notificationsData[0] == "success") {
        for (Map<String, dynamic> i in notificationsData[1]) {
          notificationsList.add(Notification.fromJson(i));
        }
        var seenNotificationsData =
            await HomeServices.seenNotifications(token, userId);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  getGroupResult(roundId) async {
    usersSortList.clear();
    try {
      isLoadingResult = true;
      update();
      Get.to(() => GroupResultScreen());
      var groupResultData = await GroupServices.getGroupResult(token, roundId);
      for (Map<String, dynamic> i in groupResultData[0]) {
        usersSortList.add(UserSort.fromJson(i));
      }
      groupInfo = Group.fromJson(groupResultData[1]);
    } catch (e) {
      print(e);
    } finally {
      isLoadingResult = false;
      update();
    }
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

  @override
  void onInit() async {
    await getUserToken();
    await getNotifications();
    super.onInit();
  }
}
