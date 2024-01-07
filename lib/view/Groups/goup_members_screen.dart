import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/groups_controller.dart';
import '../../theme/constants.dart';

class GroupMembersScreen extends StatelessWidget {
  GroupMembersScreen({Key? key, required this.groupName})
      : super(
          key: key,
        );
  final String groupName;
  final GroupsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<GroupsController>(builder: (controller) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          width: double.infinity,
          child: controller.membersIsLoading
              ? Center(
                  child: SizedBox(
                      width: size.width * 0.5,
                      child: Lottie.asset("assets/images/loading0.json")),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                                vertical: size.height * 0.02),
                            child: Text.rich(
                              textDirection: TextDirection.rtl,
                              TextSpan(
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w),
                                      child: SizedBox(
                                          width: 28.w,
                                          child: Image.asset(
                                              'assets/icons/groups.png')),
                                    ),
                                  ),
                                  TextSpan(text: groupName)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                                vertical: size.height * 0.02),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                  size: size.width * 0.1,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.groupMembersList.length,
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
                                              "https://suaalplus.sy/public/img/${controller.groupMembersList[index].avatar}"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.01,
                                              horizontal: size.width * 0.01),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller
                                                        .groupMembersList[index]
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
                                                            .groupMembersList[
                                                                index]
                                                            .studyYear) ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    height: 0,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                            controller.groupMembersList[index]
                                                        .correctQuestions
                                                        .toString() ==
                                                    "null"
                                                ? "0"
                                                : controller
                                                    .groupMembersList[index]
                                                    .correctQuestions
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                height: 0,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                            height: size.height * 0.04,
                                            child: Image.asset(
                                                "assets/icons/person.png"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ],
                ),
        ),
      ));
    });
  }
}
