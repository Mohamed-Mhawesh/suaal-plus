import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/last_semester_sort_controller.dart';
import '../../theme/constants.dart';

class LastSemesterSortScreen extends StatelessWidget {
  LastSemesterSortScreen({Key? key}) : super(key: key);
  final LastSemesterSortController controller =
      Get.put(LastSemesterSortController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: GetBuilder<LastSemesterSortController>(builder: (controller) {
        if (controller.isLoading) {
          return Center(
            child: SizedBox(
                width: size.width * 0.5,
                child: Lottie.asset("assets/images/loading0.json")),
          );
        } else {
          return Container(
            height: size.height,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white70),
            child: controller.noPreviousSemester
                ? const Center(
                    child: Text("لا يوجد موسم سابق"),
                  )
                : Column(
                    children: [
                      const Center(
                        child: Text("ترتيب الموسم السابق"),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: AnimationLimiter(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.008),
                              itemCount: controller.lastSemesterSortList.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: -100.w,
                                    child: FadeInAnimation(
                                      child: Container(
                                          height: size.height * 0.09,
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: kPrimaryColor
                                                      .withOpacity(0.3),
                                                  width: 2),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12.0),
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 40.w,
                                                    child: Image.network(
                                                        "https://suaalplus.sy/public/img/${controller.lastSemesterSortList[index].avatar}"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                size.height *
                                                                    0.01,
                                                            horizontal:
                                                                size.width *
                                                                    0.01),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          controller
                                                                  .lastSemesterSortList[
                                                                      index]
                                                                  .username ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              height: 1),
                                                        ),
                                                        Text(
                                                          controller.getUserStudyYear(
                                                                  controller
                                                                      .lastSemesterSortList[
                                                                          index]
                                                                      .studyYear) ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              height: 0,
                                                              color: Colors
                                                                  .blueGrey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.height * 0.01,
                                                    horizontal:
                                                        size.width * 0.04),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      controller
                                                                  .lastSemesterSortList[
                                                                      index]
                                                                  .correctQuestions
                                                                  .toString() ==
                                                              "null"
                                                          ? "0"
                                                          : controller
                                                              .lastSemesterSortList[
                                                                  index]
                                                              .correctQuestions
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          height: 0,
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    controller.getSortIcon(
                                                        size, index + 1)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        )),
                      ),
                    ],
                  ),
          );
        }
      }),
    ));
  }
}
