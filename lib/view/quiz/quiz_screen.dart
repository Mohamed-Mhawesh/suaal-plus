import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Components/individually_progress_timer.dart';

import '../../controllers/quiz_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../../theme/constants.dart';
import '../Components/no_internet_screen.dart';
import '../Components/question_card.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({
    Key? key,
  }) : super(key: key);

  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.bottomSheet(
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            height: size.height * 0.25,
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "هل تريد انهاء الامتحان؟",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 120.w,
                        child: ElevatedBtn(
                          text: "نعم",
                          fontSize: 14.sp,
                          press: () async {
                            if (await ConnectivityCheck.checkConnect() ==
                                false) {
                              controller.noInternet(context, size);
                            } else {
                              Get.back();
                              controller.count();
                              controller.timer!.cancel();
                              controller.itemController =
                                  ItemScrollController();

                              controller.sendQuizResult();
                              controller.getResultDialog(context);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          width: 120.w,
                          child: ElevatedBtn(
                              text: "لا",
                              fontSize: 14.sp,
                              press: () {
                                Get.back();
                                controller.itemController =
                                    ItemScrollController();
                              }))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) {
                if (controller.isLoading) {
                  controller.checkInternet();
                  return Center(
                      child: SizedBox(
                          width: size.width * 0.5,
                          child: Lottie.asset("assets/images/loading0.json")));
                } else {
                  if (controller.isConnected) {
                    return Stack(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(
                                  flex: 2,
                                ),
                                Text(
                                  controller.subjectName,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                ),
                                const Spacer(flex: 1),
                                IndividuallyProgressTimer()
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 44.w,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemBuilder: (context, index) =>
                                              QuestionIndex(
                                            questionsModel:
                                                controller.questions[index],
                                            index: index,
                                          ),
                                          itemCount:
                                              controller.questions.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ScrollablePositionedList.builder(
                                          itemScrollController:
                                              controller.itemController,
                                          itemPositionsListener:
                                              controller.itemPositionsListener,
                                          addAutomaticKeepAlives: false,
                                          itemBuilder: (context, index) =>
                                              QuestionCard(
                                            questionsModel:
                                                controller.questions[index],
                                            index: index,
                                          ),
                                          itemCount:
                                              controller.questions.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 6.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              width: size.width * 0.3,
                              height: 50.h,
                              child: FloatingActionButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        height: size.height * 0.25,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.02,
                                            vertical: size.height * 0.01),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "هل تريد انهاء الامتحان؟",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: ElevatedBtn(
                                                      text: "نعم",
                                                      fontSize: 14.sp,
                                                      press: () async {
                                                        if (await ConnectivityCheck
                                                                .checkConnect() ==
                                                            false) {
                                                          controller.noInternet(
                                                              context, size);
                                                        } else {
                                                          Get.back();
                                                          controller.count();
                                                          controller.timer!
                                                              .cancel();
                                                          controller
                                                                  .itemController =
                                                              ItemScrollController();

                                                          controller
                                                              .sendQuizResult();
                                                          controller
                                                              .getResultDialog(
                                                                  context);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: 120.w,
                                                      child: ElevatedBtn(
                                                          text: "لا",
                                                          fontSize: 14.sp,
                                                          press: () {
                                                            Get.back();
                                                            controller
                                                                    .itemController =
                                                                ItemScrollController();
                                                          }))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "تسليم",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              width: size.width * 0.3,
                              height: 50.h,
                              child: FloatingActionButton(
                                  onPressed: () {
                                    controller.getDialog(context);
                                  },
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "مساعدة",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ]);
                  } else {
                    return NoInternetScreen(
                      size: size,
                      tryAgain: () {
                        controller.getQuizData(controller.subjectId, context);
                      },
                    );
                  }
                }
              }),
        ),
      ),
    );
  }
}
