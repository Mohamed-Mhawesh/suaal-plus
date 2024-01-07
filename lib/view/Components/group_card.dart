import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Groups/goup_members_screen.dart';
import '../../controllers/groups_controller.dart';

class GroupCard extends StatelessWidget {
  final int groupId;
  final int roundId;
  final String groupName;
  final String subject;
  final int usersNumber;
  final String adminName;
  final int numberOfQuestions;
  final DateTime startTime;
  final DateTime endTime;

  final String firstButtonText;

  final String secondButtonText;

  GroupCard({
    required this.groupName,
    required this.subject,
    required this.usersNumber,
    required this.adminName,
    required this.numberOfQuestions,
    required this.startTime,
    required this.endTime,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.groupId,
    required this.roundId,
  });

  GroupsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          gradient: LinearGradient(
              colors: [kPrimaryColor, Color(0xffADAEFB)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groupName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => GroupMembersScreen(
                                groupName: groupName,
                              ));
                          controller.getGroupMembers(groupId);
                        },
                        child: Container(
                            padding: EdgeInsets.all(6),
                            height: 28.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                                color: kSecondColor, shape: BoxShape.circle),
                            child: Image.asset('assets/icons/details.png'))),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      textDirection: TextDirection.rtl,
                      TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: SizedBox(
                                  width: 20.w,
                                  child: Image.asset('assets/icons/admin.png')),
                            ),
                          ),
                          TextSpan(text: adminName)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Text.rich(
                          textDirection: TextDirection.rtl,
                          TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: SizedBox(
                                      width: 20.w,
                                      child: Image.asset(
                                          'assets/icons/questions_num.png')),
                                ),
                              ),
                              TextSpan(text: '$numberOfQuestions')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text.rich(
                          textDirection: TextDirection.rtl,
                          TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: SizedBox(
                                      width: 20.w,
                                      child: Image.asset(
                                          'assets/icons/group_users.png')),
                                ),
                              ),
                              TextSpan(text: '$usersNumber')
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: SizedBox(
                              width: 20.w,
                              child: Image.asset('assets/icons/time.png')),
                        ),
                        Text(
                          '''${startTime.month}/${startTime.day}    ${startTime.hour}:${startTime.minute}''',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    subject.length >= 20
                        ? SizedBox(
                            height: 20.h,
                            width: 160.w,
                            child: Marquee(
                              text: "$subject    ",
                              style: TextStyle(
                                color: kSecondColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.w,
                              accelerationDuration: Duration(seconds: 2),
                              pauseAfterRound: Duration(seconds: 2),
                            ))
                        : Text(
                            subject,
                            style: TextStyle(
                              color: kSecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible:
                              controller.getSecondButtonVisibility(groupId),
                          child: InkWell(
                            onTap: () {
                              controller.getSecondButtonFunction(groupId);
                            },
                            child: Container(
                              width: 72.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2.w,
                                      color: kSecondColor.withOpacity(0.8))),
                              child: Center(
                                child: Text(
                                  controller.getSecondButtonText(groupId),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: kSecondColor.withOpacity(0.8),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Visibility(
                          visible: controller.getFirsButtonVisibility(
                              groupId, startTime),
                          child: InkWell(
                            onTap: () {
                              controller.getFirstButtonFunction(
                                  groupId, roundId, groupName, context);
                            },
                            child: Container(
                              width: 72.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2.w,
                                    color: kSecondColor.withOpacity(0.1)),
                                color: kSecondColor.withOpacity(0.8),
                              ),
                              child: Center(
                                child: Text(
                                  controller.getFirstButtonText(groupId),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
