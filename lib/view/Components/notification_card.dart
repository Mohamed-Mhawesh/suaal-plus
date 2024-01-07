import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/view/sorting/last_semester_sort_screen.dart';

import '../../controllers/notifications_controller.dart';
import '../../theme/constants.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard({
    super.key,
    required this.size,
    required this.title,
    required this.id,
    this.description,
    this.roundId,
    this.semesterId,
    required this.showTime,
    required this.hadSeen,
  });

  final Size size;
  final int id;
  final String title;
  final String? description;
  final int? roundId;
  final int? semesterId;
  final DateTime showTime;
  final int hadSeen;

  final NotificationsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (semesterId != null) {
      return InkWell(
        onTap: () {
          Get.to(LastSemesterSortScreen());
        },
        child: Container(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(0, 2)),
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(2, 0)),
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 80.h,
            child: Stack(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.001),
                          width: size.width * 0.07,
                          child: Image.asset("assets/icons/notification.png"),
                        ),
                        Text("${showTime.day}/${showTime.month}",
                            style: TextStyle(fontSize: 12.sp)),
                        Text(
                          "${showTime.hour}:${showTime.minute}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        )
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.002,
                        ),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                                width: size.width * 0.7,
                                child: Text(
                                  description ?? "",
                                  style: TextStyle(fontSize: 12.sp),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.004,
                        ),
                      ],
                    )
                  ],
                ),
                Visibility(
                  visible: hadSeen == 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.01,
                          vertical: size.height * 0.01),
                      width: size.width * 0.08,
                      child: Lottie.asset("assets/images/CirclePop.json"),
                    ),
                  ),
                )
              ],
            )),
      );
    } else if (roundId != null) {
      return InkWell(
        onTap: () {
          controller.getGroupResult(roundId);
        },
        child: Container(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(0, 2)),
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(2, 0)),
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 80.h,
            child: Stack(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.001),
                          width: size.width * 0.07,
                          child: Image.asset(roundId == null
                              ? "assets/icons/notification.png"
                              : "assets/icons/groups.png"),
                        ),
                        Text("${showTime.day}/${showTime.month}",
                            style: TextStyle(fontSize: 12.sp)),
                        Text(
                          "${showTime.hour}:${showTime.minute}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp),
                        )
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.01),
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.002,
                        ),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                                width: size.width * 0.7,
                                child: Text(
                                  description ?? "",
                                  style: TextStyle(fontSize: 12.sp),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.004,
                        ),
                      ],
                    )
                  ],
                ),
                Visibility(
                  visible: hadSeen == 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.01,
                          vertical: size.height * 0.01),
                      width: size.width * 0.08,
                      child: Lottie.asset("assets/images/CirclePop.json"),
                    ),
                  ),
                )
              ],
            )),
      );
    } else {
      return Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 2)),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(2, 0)),
          ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          height: 80.h,
          child: Stack(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: size.height * 0.001),
                        width: size.width * 0.07,
                        child: Image.asset(roundId == null
                            ? "assets/icons/notification.png"
                            : "assets/icons/groups.png"),
                      ),
                      Text("${showTime.day}/${showTime.month}",
                          style: TextStyle(fontSize: 12.sp)),
                      Text(
                        "${showTime.hour}:${showTime.minute}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp),
                      )
                    ],
                  ),
                  const VerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01),
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.002,
                      ),
                      Expanded(
                        child: Center(
                          child: SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                description ?? "",
                                style: TextStyle(fontSize: 12.sp),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.004,
                      ),
                    ],
                  )
                ],
              ),
              Visibility(
                visible: hadSeen == 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.01,
                        vertical: size.height * 0.01),
                    width: size.width * 0.08,
                    child: Lottie.asset("assets/images/CirclePop.json"),
                  ),
                ),
              )
            ],
          ));
    }
  }
}
