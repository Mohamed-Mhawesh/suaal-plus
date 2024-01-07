import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/sorting/last_semester_sort_screen.dart';
import '../../controllers/sort_controller.dart';
import '../Components/no_internet_screen.dart';
import '../home/home_page.dart';

class SortingScreen extends StatelessWidget {
  SortingScreen({Key? key}) : super(key: key);
  SortController controller = Get.put(SortController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SortController>(builder: (controller) {
      if (controller.isLoading) {
        return Center(
          child: SizedBox(
              width: size.width * 0.5,
              child: Lottie.asset("assets/images/loading0.json")),
        );
      } else {
        if (controller.isConnected) {
          return Container(
            height: size.height,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white70),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          child: AnimationLimiter(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.008),
                            itemCount: controller.fullSortList.length,
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
                                                      "https://suaalplus.sy/public/img/${controller.fullSortList[index].avatar}"),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.height * 0.01,
                                                      horizontal:
                                                          size.width * 0.01),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .fullSortList[
                                                                    index]
                                                                .username ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1),
                                                      ),
                                                      Text(
                                                        controller.getUserStudyYear(
                                                                controller
                                                                    .fullSortList[
                                                                        index]
                                                                    .studyYear) ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            height: 0,
                                                            color:
                                                                Colors.blueGrey,
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
                                                  vertical: size.height * 0.01,
                                                  horizontal:
                                                      size.width * 0.04),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller
                                                                .fullSortList[
                                                                    index]
                                                                .correctQuestions
                                                                .toString() ==
                                                            "null"
                                                        ? "0"
                                                        : controller
                                                            .fullSortList[index]
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
                    Container(
                        height: size.height * 0.09,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: kPrimaryColor.withOpacity(0.3),
                                width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    (controller.currentUserSort + 1).toString(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: Image.network(
                                      "https://suaalplus.sy/public/img/${controller.userAvatar}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.01,
                                      horizontal: size.width * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.username,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            height: 1),
                                      ),
                                      Text(
                                        controller.userStudYear,
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
                                    controller.userCorrectQuestions.toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        height: 0,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  controller.getSortIcon(
                                      size, controller.currentUserSort + 1)
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: size.height * 0.16,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: kSecondColor,
                              child: const Icon(Icons.last_page),
                              onPressed: () {
                                Get.to(LastSemesterSortScreen());
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return NoInternetScreen(
            size: size,
            tryAgain: () {
              Get.offAll(() => const HomePage());
            },
          );
        }
      }
    });
  }
}
