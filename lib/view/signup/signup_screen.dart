import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/helpers/valid_input.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Components/my_choice_chip.dart';
import 'package:suaal_plus/view/Login/login_screen.dart';
import 'package:suaal_plus/view/Welcome/welcome_screen.dart';
import '../../controllers/signup_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../../theme/constants.dart';
import '../Components/already_have_an_account_check.dart';
import '../Components/no_internet_screen.dart';
import '../Components/rounded_input_field.dart';
import '../Components/rounded_password_field.dart';

class SignUpScreen extends StatelessWidget {
  SignupController controller = Get.put(SignupController());

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const WelcomeScreen());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            width: double.infinity,
            height: size.height,
            child: GetBuilder<SignupController>(builder: (controller) {
              if (controller.isConnected) {
                return SingleChildScrollView(
                  child: Form(
                    key: controller.formState1,
                    autovalidateMode: controller.autoValidateMode1,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: size.width * 0.5,
                          height: size.height * 0.3,
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 8.h),
                            child: Text(
                              "- أدخل الاسم الذي ستظهر به بين زملائك في التطبيق",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ),

                        RoundedInputField(
                          valid: (val) {
                            return validUsername(val!, 2, 12);
                          },
                          controller: controller.username,
                          hintText: "اسم المستخدم",
                          icon: Icons.person,
                          onChanged: (value) {
                            controller.checkUsername(value);
                          },
                          kbType: TextInputType.name,
                        ),

                        // RoundedInputField(
                        // valid: (val) {
                        // return validPhone(val!, 10, 10);
                        // },
                        // controller: controller.phone,
                        // hintText: "رقم الهاتف",
                        // icon: Icons.phone,
                        // onChanged: (value) {
                        //   controller.checkPhone(value);
                        // },
                        // kbType: TextInputType.phone,
                        // ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 16.h, right: 20.w, left: 20.w),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: IntlPhoneField(
                              validator: (val) {
                                return validPhone(val.toString(), 10, 10);
                              },
                              cursorColor: kPrimaryColor,
                              autovalidateMode: AutovalidateMode.disabled,
                              showCountryFlag: false,
                              dropdownTextStyle: GoogleFonts.cairo(
                                  color: kPrimaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                iconColor: kPrimaryColor,
                                counterStyle: GoogleFonts.cairo(
                                    height: 1.h, fontSize: 12.sp),

                                prefixIconColor: kPrimaryColor,

                                errorStyle: GoogleFonts.cairo(fontSize: 14.sp),

                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 20.w),
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2.h,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.h,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.h,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.h,
                                  ),
                                ),

                                // icon: Icon(
                                //   icon,
                                //   color: kPrimaryColor,
                                // ),

                                // labelText: "sss",
                                hintText: "900000000",
                                hintStyle: GoogleFonts.cairo(
                                    letterSpacing: 1.w,
                                    color: Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              onCountryChanged: (country) {
                                print(country.code.length);
                              },
                              countries: const [
                                Country(
                                  name: "Syrian Arab Republic",
                                  nameTranslations: {
                                    "sk": "Sýria",
                                    "se": "Syria",
                                    "pl": "Syria",
                                    "no": "Syria",
                                    "ja": "シリア",
                                    "it": "Siria",
                                    "zh": "叙利亚",
                                    "nl": "Syrië",
                                    "de": "Syrien",
                                    "fr": "Syrie",
                                    "es": "Siria",
                                    "en": "Syria",
                                    "pt_BR": "Síria",
                                    "sr-Cyrl": "Сирија",
                                    "sr-Latn": "Sirija",
                                    "zh_TW": "敘利亞",
                                    "tr": "Suriye",
                                    "ro": "Siria",
                                    "ar": "سوريا",
                                    "fa": "سوریه",
                                    "yue": "阿拉伯敘利亞共和國"
                                  },
                                  flag: "🇸🇾",
                                  code: "SY",
                                  dialCode: "963",
                                  minLength: 9,
                                  maxLength: 9,
                                )
                              ],
                              initialCountryCode: 'SY',
                              invalidNumberMessage: "رقم هاتف غير صالح",
                              style: GoogleFonts.cairo(),
                              onChanged: (phone) {
                                controller.checkPhone(phone.toString());
                                controller.phone.text = phone.completeNumber
                                    .toString()
                                    .replaceAll('+', '');
                                print(controller.phone.text);
                              },
                            ),
                          ),
                        ),
                        RoundedPasswordField(
                          icon: controller.isPasswordShow
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          showOrHide: controller.showHidePassword,
                          isObscureText: !controller.isPasswordShow,
                          valid: (val) {
                            return validInput(val!, 4, 16, "password");
                          },
                          controller: controller.password,
                          hint: "كلمة المرور",
                          onChanged: (value) {},
                        ),
                        Visibility(
                          visible: controller.isLoading,
                          child: Center(
                            child: SizedBox(
                                width: size.width * 0.2,
                                child: Lottie.asset(
                                    "assets/images/loading0.json")),
                          ),
                        ),

                        Visibility(
                          visible: controller.phone.text.length > 3,
                          child: ElevatedBtn(
                            text: "التالي",
                            fontSize: 16.sp,
                            press: () async {
                              if (await ConnectivityCheck.checkConnect() ==
                                  false) {
                                controller.noInternet(context, size);
                              } else {
                                controller.goToSignUp2();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Get.off(() => LoginScreen());
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        Center(
                            child: privacyPolicyLinkAndTermsOfService(
                                size, context)),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
                  ),
                );
              } else {
                return NoInternetScreen(
                  size: size,
                  tryAgain: () {
                    controller.onInit();
                  },
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

Widget privacyPolicyLinkAndTermsOfService(Size size, BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
    child: Center(
        child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                text: 'عن طريق المتابعة، أنت توافق على  ',
                style: normalTextStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: 'شروط الاستخدام',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.privacyText,
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
//
                                          SizedBox(
                                              width: size.width * 0.5,
                                              child: ElevatedBtn(
                                                  text: "تم",
                                                  fontSize: 16.sp,
                                                  press: () {
                                                    Get.back();
                                                  }))
                                        ],
                                      ),
                                    ),
                                  ));
                          // code to open / launch terms of service link here
                        }),
                  TextSpan(
                      text: ' و ',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'سياسة الخصوصية',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  controller.privacyText,
                                                  style: TextStyle(
                                                      fontSize: 14.sp),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.5,
                                                    child: ElevatedBtn(
                                                        text: "تم",
                                                        fontSize: 16.sp,
                                                        press: () {
                                                          Get.back();
                                                        }))
                                              ],
                                            ),
                                          ),
                                        ));
                                // code to open / launch privacy policy link here
                              })
                      ])
                ]))),
  );
}
