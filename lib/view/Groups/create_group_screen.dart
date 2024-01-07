import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/controllers/create_group_controller.dart';
import 'package:suaal_plus/helpers/validCreateInput.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Components/rounded_input_field.dart';
import 'package:suaal_plus/view/home/home_page.dart';

import '../../helpers/valid_input.dart';
import '../../theme/constants.dart';
import '../Components/create_group_choice_chip.dart';

class CreateGroupScreen extends StatelessWidget {
  CreateGroupScreen({Key? key}) : super(key: key);
  CreateGroupController controller = Get.put(CreateGroupController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => HomePage());
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          height: size.height,
          width: double.infinity,
          color: Colors.white,
          child: GetBuilder<CreateGroupController>(builder: (controller) {
            if (controller.isLoading) {
              return Center(
                  child: SizedBox(
                      width: size.width * 0.5,
                      child: Lottie.asset("assets/images/loading0.json")));
            } else {
              return Stack(
                children: [
                  Form(
                    key: controller.formState,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          RoundedInputField(
                              hintText: "اسم المجموعة",
                              icon: Icons.group,
                              onChanged: (value) {
                                controller.checkGroupName(value);
                              },
                              kbType: TextInputType.name,
                              valid: (val) {
                                return validGroupName(val!, 2, 20);
                              },
                              controller: controller.groupName),
                          ExpansionTile(
                            tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
                            title: Text(
                              "مواد المجموعة",
                              style: GoogleFonts.cairo(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              RoundedInputField(
                                  icon: Icons.search,
                                  controller: controller.editingController,
                                  hintText: "اسم المادة",
                                  kbType: TextInputType.name,
                                  onChanged: (value) {
                                    controller.filterSearchResults(value);
                                  },
                                  valid: (val) {}),
                              SizedBox(
                                height: size.height * 0.3,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.availableSubjectsList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 8.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 10)
                                          ],
                                          gradient: LinearGradient(
                                              colors: [
                                                kPrimaryColor,
                                                Color(0xffADAEFB)
                                              ],
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topLeft)),
                                      child: CheckboxListTile(
                                          enabled:
                                              !controller.isQuestionsNumLoading,
                                          checkColor: Colors.white,
                                          activeColor: kPrimaryColor,
                                          checkboxShape: CircleBorder(),
                                          title: Text(
                                            controller
                                                    .availableSubjectsList[
                                                        index]
                                                    .name ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: controller
                                              .availableSubjectsList[index]
                                              .value,
                                          onChanged: (bool? value) {
                                            controller
                                                .availableSubjectsList[index]
                                                .value = value!;
                                            controller
                                                .changeGroupQuizSubjects();
                                            controller.getQuestionsNum(
                                                controller.token);
                                          }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: size.height * 0.08,
                                width: size.width * 0.44,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 10)
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          kPrimaryColor,
                                          Color(0xffADAEFB)
                                        ],
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Text(
                                        "عدد الأسئلة",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: size.height * 0.06,
                                      width: size.width * 0.16,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: kPrimaryColor, width: 2.h),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                            controller.changeQuestionsNum(
                                                val.toString());
                                          },
                                          focusColor: kPrimaryColor,
                                          underline: const SizedBox(),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height * 0.08,
                                width: size.width * 0.44,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 10)
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          kPrimaryColor,
                                          Color(0xffADAEFB)
                                        ],
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Text(
                                        "مجموعة خاصة",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                      child: Switch(
                                        value: controller.isPrivate,
                                        activeTrackColor: kPrimaryColor,
                                        activeColor: kPrimaryColor,
                                        onChanged: (bool value) {
                                          controller.changeGroupType(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: controller.isPrivate,
                            child: Container(
                              margin: EdgeInsets.only(top: 8.h),
                              child: RoundedInputField(
                                  hintText: "كلمة مرور المجموعة",
                                  icon: Icons.password,
                                  onChanged: (value) {},
                                  kbType: TextInputType.visiblePassword,
                                  valid: (val) {
                                    return validInput(val!, 2, 20, "password");
                                  },
                                  controller: controller.groupPassword),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CreateGroupChoiceChip(
                                    chipText: "إجراء الإختبار مع مجموعتك",
                                    chipId: 1,
                                    process: "in"),
                                CreateGroupChoiceChip(
                                    chipText: "الإشراف على مجموعتك فقط",
                                    chipId: 2,
                                    process: "in")
                              ]),
                          Center(
                            child: ElevatedBtn(
                                fontSize: 16.sp,
                                text:
                                    "${DateFormat('dd/MM/yyyy, h:mm a').format(controller.dateTime)}",
                                press: () async {
                                  DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate: controller.realDateTime,
                                          firstDate: controller.realDateTime,
                                          lastDate: DateTime(2044)) ??
                                      controller.realDateTime;

                                  TimeOfDay? time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ) ??
                                      controller.timeOfDay;
                                  DateTime newDateTime = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                                  controller.dateTime = newDateTime;
                                  controller.update();
                                  print(controller.dateTime);
                                }),
                          ),
                          ElevatedBtn(
                              fontSize: 16.sp,
                              text: "إنشاء المجموعة",
                              press: () {
                                controller.createGroup(context);
                              })
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.isCreatingGroup,
                    child: Container(
                      height: size.height,
                      color: Colors.transparent.withOpacity(0.8),
                      child: Center(
                        child: SizedBox(
                            width: size.width * 0.5,
                            child: Lottie.asset("assets/images/loading0.json")),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      )),
    );
  }
}
