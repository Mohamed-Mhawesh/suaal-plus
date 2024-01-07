import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Components/quiz_prefs_choice_chip.dart';
import 'package:suaal_plus/view/quiz/quiz_screen.dart';

import '../../controllers/quiz_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../Components/no_internet_screen.dart';

class QuizPrefsScreen extends StatelessWidget {
  QuizPrefsScreen({Key? key, required this.subId, required this.subName})
      : super(key: key);
  QuizController controller = Get.put(QuizController());
  final String? subId;
  final String? subName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: size.height,
          width: double.infinity,
          child: GetBuilder<QuizController>(
            builder: (controller) {
              if (controller.isLoading) {
                controller.checkInternet();
                return Center(
                    child: SizedBox(
                        width: size.width * 0.5,
                        child: Lottie.asset("assets/images/loading0.json")));
              } else {
                if (controller.isConnected) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                            child: SizedBox(
                                width: size.width * 0.3,
                                child: Image.asset("assets/images/logo.png"))),
                        Center(
                          child: Text(
                            controller.subjectName,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                          visible: controller.subjectYear != "5",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "نوع التعليم ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              SingleChildScrollView(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    QuizPrefsChoiceChip(
                                      process: "le",
                                      chipText: "     الكل     ",
                                      chipId: 5,
                                    ),
                                    QuizPrefsChoiceChip(
                                      process: "le",
                                      chipText: "     عام     ",
                                      chipId: 1,
                                    ),
                                    QuizPrefsChoiceChip(
                                      process: "le",
                                      chipText: "     خاص     ",
                                      chipId: 2,
                                    ),
                                    QuizPrefsChoiceChip(
                                      process: "le",
                                      chipText: "     افتراضي     ",
                                      chipId: 3,
                                    ),
                                    QuizPrefsChoiceChip(
                                      process: "le",
                                      chipText: "     مفتوح     ",
                                      chipId: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Visibility(
                          visible: controller.activeUniversity.isNotEmpty &&
                              controller.subjectYear != "5",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  "الجامعة ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.08,
                                child: ListView.builder(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.activeUniversity.length,
                                  itemBuilder: (context, index) {
                                    return QuizPrefsChoiceChip(
                                      process: "un",
                                      chipText:
                                          "   ${controller.activeUniversity[index].name}   ",
                                      chipId:
                                          controller.activeUniversity[index].id,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Visibility(
                          visible: controller.subjectYear != "5",
                          child: Container(
                            height: size.height * 0.1,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kPrimaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  child: Text(
                                    "الدورة ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kPrimaryColor, width: 2.h),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    width: size.width * 0.3,
                                    child: Center(
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        value: controller.yearTimeDropdownValue,
                                        items: controller.yearTimeCanUsed
                                            .map<DropdownMenuItem<String>>(
                                          (value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.cairo(
                                                    fontSize: 14.sp),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                          controller
                                              .changeYearTime(val.toString());
                                        },
                                        focusColor: kPrimaryColor,
                                        underline: const SizedBox(),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          height: size.height * 0.1,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: kPrimaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Text(
                                  "عدد الأسئلة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kPrimaryColor, width: 2.h),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  width: size.width * 0.3,
                                  child: Center(
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.white,
                                      value: controller
                                          .questionsNumberDropdownValue,
                                      items: controller
                                          .numbersOfQuestionsCanUsed
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.cairo(
                                                fontSize: 14.sp),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        controller
                                            .changeQuestionsNum(val.toString());
                                      },
                                      focusColor: kPrimaryColor,
                                      underline: const SizedBox(),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              controller.numbersOfQuestionsCanUsed.isNotEmpty,
                          child: SizedBox(
                            width: size.width * 0.5,
                            child: ElevatedBtn(
                              text: "ابدأ الإختبار",
                              fontSize: 16.sp,
                              press: () async {
                                if (await ConnectivityCheck.checkConnect() ==
                                    false) {
                                  controller.noInternet(context, size);
                                } else {
                                  controller.getQuizData(
                                    subId,
                                    context,
                                  );
                                  Get.to(QuizScreen());
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return NoInternetScreen(
                    size: size,
                    tryAgain: () {
                      Get.back();
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
