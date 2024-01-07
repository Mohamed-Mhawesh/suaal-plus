import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Components/no_internet_screen.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import '../../controllers/edit_profile_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../../theme/constants.dart';

import '../../helpers/valid_input.dart';
import '../Components/country_picker.dart';
import '../Components/edit_choice_chip.dart';
import '../Components/rounded_input_field.dart';
import '../Components/rounded_password_field.dart';
import '../Components/simple_shadow.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const HomePage());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            body: GetBuilder<EditProfileController>(builder: (controller) {
          if (controller.isLoading || controller.isAvatarLoading) {
            return Center(
              child: SizedBox(
                  width: size.width * 0.5,
                  child: Lottie.asset("assets/images/loading0.json")),
            );
          } else {
            if (controller.isConnected) {
              return Form(
                key: controller.formState,
                autovalidateMode: controller.autoValidateMode,
                child: SingleChildScrollView(
                  controller: controller.editProfileScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 260.h,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            gradient: LinearGradient(
                                colors: [Color(0xff8586ff), Color(0xff8586ff)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: size.height,
                              width: size.width,
                              child: Lottie.asset("assets/images/effect.json"),
                            ),
                            SizedBox(
                              height: size.height,
                              width: size.width,
                              child: Lottie.asset("assets/images/effect.json"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Image.network(
                                      "https://suaalplus.sy/public/img/${controller.chosenAvatar}"),
                                ),
                                Text(
                                  controller.username.text,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                                Text(
                                  controller.stringStudyYear,
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: size.height * 0.02),
                                child: SimpleShadow(
                                    child: IconButton(
                                        onPressed: () {
                                          Get.offAll(() => const HomePage());
                                        },
                                        icon: Icon(
                                          Icons.subdirectory_arrow_left,
                                          color: Colors.white,
                                          size: size.width * 0.1,
                                        ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      RoundedInputField(
                        valid: (val) {
                          return validNewUsername(
                              val!, 2, 12, controller.storageCurrentUsername);
                        },
                        controller: controller.username,
                        hintText: "اسم المستخدم",
                        icon: Icons.person,
                        onChanged: (value) {
                          controller.checkUsername(value);
                        },
                        kbType: TextInputType.name,
                      ),
                      IgnorePointer(
                        child: RoundedInputField(
                          valid: (val) {
                            return validInput(val!, 10, 10, "phoneNumber");
                          },
                          controller: controller.phone,
                          hintText: "رقم الهاتف",
                          icon: Icons.phone,
                          onChanged: (value) {},
                          kbType: TextInputType.phone,
                        ),
                      ),
                      RoundedPasswordField(
                        icon: controller.isPasswordShow
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        showOrHide: controller.showHidePassword,
                        isObscureText: !controller.isPasswordShow,
                        valid: (val) {
                          return validNewPassword(val!, 4, 16);
                        },
                        controller: controller.newPassword,
                        hint: "كلمة المرور الجديدة",
                        onChanged: (value) {},
                      ),

                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "- اختر الصورة الرمزية التي ستظهر بها في التطبيق",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4)),
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: Offset(2, 0)),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        height: size.height * 0.12,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.008),
                            itemCount: controller.avatars.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.chooseAvatar(
                                      controller.avatars[index].name);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 2.w),
                                    decoration: BoxDecoration(
                                      color: controller.chosenAvatar ==
                                              controller.avatars[index].name
                                          ? kLightColor.withOpacity(0.2)
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: controller.chosenAvatar ==
                                                  controller.avatars[index].name
                                              ? kPrimaryColor
                                              : Colors.transparent,
                                          width: 2.h),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(
                                        "https://suaalplus.sy/public/img/${controller.avatars[index].name}"),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "- أدخل معلوماتك الحقيقية من فضلك",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      RoundedInputField(
                        valid: (val) {
                          return validInput(val!, 2, 20, "username");
                        },
                        controller: controller.firstname,
                        hintText: "الاسم الأول",
                        icon: Icons.person,
                        onChanged: (value) {},
                        kbType: TextInputType.name,
                      ),
                      RoundedInputField(
                        valid: (val) {
                          return validInput(val!, 2, 20, "username");
                        },
                        controller: controller.lastname,
                        hintText: "الاسم الأخير",
                        icon: Icons.person,
                        onChanged: (value) {},
                        kbType: TextInputType.name,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "- أنت...",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      Row(
                        children: [
                          EditChoiceChip(
                            process: "gr",
                            chipText: "      طالب      ",
                            chipId: 0,
                          ),
                          EditChoiceChip(
                            process: "gr",
                            chipText: "     متخرج     ",
                            chipId: 1,
                          ),
                        ],
                      ),

                      // Center(
                      //   child: RoundedInputField(
                      //     valid: (val) {
                      //       return validInput(val!, 10, 100, 'email');
                      //     },
                      //     controller: controller.email,
                      //     hintText: "بريدك الإلكتروني",
                      //     onChanged: (value) {},
                      //     kbType: TextInputType.emailAddress,
                      //   ),
                      // ),
                      CountryPicker(
                          countryName: controller.chosenPCountry,
                          onCountryChanged: (c) {
                            controller.chosenPCountry = c;
                          }),
                      SizedBox(
                        height: size.height * 0.008,
                      ),
                      Visibility(
                        visible: controller.chosenPCountry == "🇸🇾    Syria"
                            ? true
                            : false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "- تُقيم في...",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "      دمشق      ",
                                    chipId: 1,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     ريف دمشق     ",
                                    chipId: 2,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     حلب     ",
                                    chipId: 3,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     حمص     ",
                                    chipId: 4,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     حماة     ",
                                    chipId: 5,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     اللاذقية     ",
                                    chipId: 6,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     إدلب     ",
                                    chipId: 7,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     الحسكة     ",
                                    chipId: 8,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     دير الزور     ",
                                    chipId: 9,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     طرطوس     ",
                                    chipId: 10,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     الرقة     ",
                                    chipId: 11,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     درعا     ",
                                    chipId: 12,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     السويداء     ",
                                    chipId: 13,
                                  ),
                                  EditChoiceChip(
                                    process: "ci",
                                    chipText: "     القنيطرة     ",
                                    chipId: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("- المحافظة"),
                      // ),
                      Visibility(
                        visible: controller.graduated == 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "- ما هو نوع تعليمك؟",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  EditChoiceChip(
                                    process: "le",
                                    chipText: "     عام     ",
                                    chipId: 1,
                                  ),
                                  EditChoiceChip(
                                    process: "le",
                                    chipText: "     خاص     ",
                                    chipId: 2,
                                  ),
                                  EditChoiceChip(
                                    process: "le",
                                    chipText: "     افتراضي     ",
                                    chipId: 3,
                                  ),
                                  EditChoiceChip(
                                    process: "le",
                                    chipText: "     مفتوح     ",
                                    chipId: 4,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "- ما هي جامعتك؟",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.activeUniversity.length,
                                  itemBuilder: (context, index) {
                                    return EditChoiceChip(
                                      process: "un",
                                      chipText:
                                          "   ${controller.activeUniversity[index].name}   ",
                                      chipId:
                                          controller.activeUniversity[index].id,
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "- أنت الآن في السنة...",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  EditChoiceChip(
                                    process: "st",
                                    chipText: "     الأولى     ",
                                    chipId: 1,
                                  ),
                                  EditChoiceChip(
                                    process: "st",
                                    chipText: "     الثانية     ",
                                    chipId: 2,
                                  ),
                                  EditChoiceChip(
                                    process: "st",
                                    chipText: "     الثالثة     ",
                                    chipId: 3,
                                  ),
                                  EditChoiceChip(
                                    process: "st",
                                    chipText: "     الرابعة     ",
                                    chipId: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("- تاريخ الميلاد"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("- المهنة"),
                      // ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: size.width * 0.4,
                            child: ElevatedBtn(
                              text: "حفظ",
                              fontSize: 16.sp,
                              press: () async {
                                if (await ConnectivityCheck.checkConnect() ==
                                    false) {
                                  controller.noInternet(context, size);
                                } else {
                                  await controller.saveEdits();
                                  if (controller.areEditsValid) {
                                    print(
                                        "areEditsValid==${controller.areEditsValid}");
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            GetBuilder<EditProfileController>(
                                                builder: (controller) {
                                              return AlertDialog(
                                                insetPadding: EdgeInsets.zero,
                                                title: Text(
                                                  "أدخل كلمة المرور الحالية لتأكيد العملية",
                                                  style: TextStyle(
                                                      fontSize: 16.sp),
                                                ),
                                                content: SizedBox(
                                                  height: 180.h,
                                                  child: Column(
                                                    children: [
                                                      RoundedPasswordField(
                                                        icon: controller
                                                                .isCurrentPasswordShow
                                                            ? const Icon(Icons
                                                                .visibility)
                                                            : const Icon(Icons
                                                                .visibility_off),
                                                        showOrHide: controller
                                                            .showHideCurrentPassword,
                                                        isObscureText: !controller
                                                            .isCurrentPasswordShow,
                                                        valid: (val) {
                                                          return validCurrentPassword(
                                                              val!,
                                                              4,
                                                              16,
                                                              controller
                                                                  .storageCurrentPassword);
                                                        },
                                                        controller: controller
                                                            .currentPassword,
                                                        hint:
                                                            "كلمة المرور الحالية",
                                                        onChanged: (value) {},
                                                      ),
                                                      Visibility(
                                                          visible: !controller
                                                              .isPasswordCorrect,
                                                          child: Text(
                                                            "تأكد من إدخال كلمة المرور بشكل صحيح",
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .redAccent),
                                                          )),
                                                      Visibility(
                                                          visible: controller
                                                              .isDoingEdits,
                                                          child: Center(
                                                            child: SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.2,
                                                                child: Lottie.asset(
                                                                    "assets/images/loading0.json")),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  Center(
                                                    child: ElevatedBtn(
                                                        text: "تأكيد",
                                                        fontSize: 16.sp,
                                                        press: () async {
                                                          if (await ConnectivityCheck
                                                                  .checkConnect() ==
                                                              false) {
                                                            controller
                                                                .noInternet(
                                                                    context,
                                                                    size);
                                                          } else {
                                                            if (controller
                                                                    .currentPassword
                                                                    .text ==
                                                                controller
                                                                    .storageCurrentPassword) {
                                                              controller
                                                                  .doEdits();
                                                            } else {
                                                              controller
                                                                      .isPasswordCorrect =
                                                                  false;
                                                              controller
                                                                  .update();
                                                              print(
                                                                  "current password does not match");
                                                            }
                                                          }
                                                        }),
                                                  )
                                                ],
                                              );
                                            }));
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                              width: size.width * 0.4,
                              child: ElevatedBtn(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  textColor: kPrimaryColor,
                                  text: "إلغاء",
                                  press: () {
                                    Get.offAll(() => const HomePage());
                                  }))
                        ],
                      ))
                    ],
                  ),
                ),
              );
            } else {
              return NoInternetScreen(size: size, tryAgain: () {});
            }
          }
        })),
      ),
    );
  }
}
