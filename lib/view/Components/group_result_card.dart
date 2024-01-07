import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

import '../../theme/constants.dart';

class GroupResultCard extends StatelessWidget {
  final int groupId;
  final String groupName;
  final String subject;
  final int usersNumber;
  final String adminName;
  final int numberOfQuestions;
  final DateTime startTime;
  final DateTime endTime;

  const GroupResultCard({
    super.key,
    required this.groupName,
    required this.subject,
    required this.usersNumber,
    required this.adminName,
    required this.numberOfQuestions,
    required this.startTime,
    required this.endTime,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          gradient: const LinearGradient(
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
                          accelerationDuration: const Duration(seconds: 2),
                          pauseAfterRound: const Duration(seconds: 2),
                        ))
                    : Text(
                        subject,
                        style: TextStyle(
                          color: kSecondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      )
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
                    // Text(
                    //   '$numberOfQuestions سؤال',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 12.sp,
                    //   ),
                    // ),
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
                                          'assets/icons/admin.png')),
                                ),
                              ),
                              TextSpan(text: adminName)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
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
                          width: 20.w,
                        ),
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

                    SizedBox(
                      height: 4.h,
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
