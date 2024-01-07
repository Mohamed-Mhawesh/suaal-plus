import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/notifications_controller.dart';
import '../../theme/constants.dart';
import '../Components/group_result_card.dart';

class GroupResultScreen extends StatelessWidget {
  GroupResultScreen({Key? key}) : super(key: key);

  final NotificationsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NotificationsController>(builder: (controller) {
      if (controller.isLoadingResult) {
        return SafeArea(
            child: Scaffold(
          body: Center(
            child: SizedBox(
                width: size.width * 0.5,
                child: Lottie.asset("assets/images/loading0.json")),
          ),
        ));
      } else {
        return SafeArea(
            child: Scaffold(
          body: Container(
            height: size.height,
            width: double.infinity,
            child: Column(
              children: [
                GroupResultCard(
                    groupName: controller.groupInfo.groupName,
                    subject: controller.groupInfo.subjects,
                    usersNumber: controller.groupInfo.usersNum,
                    adminName: controller.groupInfo.firstName,
                    numberOfQuestions: controller.groupInfo.questionsNum,
                    startTime: controller.groupInfo.fromTime,
                    endTime: controller.groupInfo.toTime,
                    groupId: controller.groupInfo.groupId),
                Expanded(
                    child: ListView.builder(
                        itemCount: controller.usersSortList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: size.height * 0.09,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor.withOpacity(0.3),
                                      width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                        child: Image.network(
                                            "https://suaalplus.sy/public/img/${controller.usersSortList[index].avatar}"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01,
                                            horizontal: size.width * 0.01),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              controller.usersSortList[index]
                                                      .username ??
                                                  "اسم الطالب",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1),
                                            ),
                                            Text(
                                              controller.getUserStudyYear(
                                                      controller
                                                          .usersSortList[index]
                                                          .studyYear) ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  height: 0,
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01,
                                        horizontal: size.width * 0.04),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${controller.groupInfo.questionsNum}/ ${controller.usersSortList[index].mark.toString()}" ??
                                              "0",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              height: 0,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        }))
              ],
            ),
          ),
        ));
      }
    });
  }
}
