import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Signup/signup_screen.dart';
import 'package:suaal_plus/view/Login/reset_otp_screen.dart';
import '../../controllers/login_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../../theme/constants.dart';
import '../../helpers/valid_input.dart';
import '../Components/already_have_an_account_check.dart';
import '../Components/rounded_password_field.dart';
import '../Welcome/welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

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
            decoration: const BoxDecoration(color: Colors.white70),
            width: double.infinity,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Lottie.asset("assets/images/effect.json"),
                ),
                SingleChildScrollView(
                  child: GetBuilder<LoginController>(
                    builder: (controller) => Form(
                      key: controller.formState,
                      autovalidateMode: controller.autoValidateMode,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/logo.png",
                            width: size.width * 0.5,
                            height: size.height * 0.3,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 16.h, right: 20.w, left: 20.w),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: IntlPhoneField(
                                validator: (val) {
                                  return validInput(
                                      val.toString(), 10, 10, "phoneNumber");
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
                                  errorStyle:
                                      GoogleFonts.cairo(fontSize: 14.sp),
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
                                  hintText: "900000000",
                                  hintStyle: hintStyle,
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
                                style: const TextStyle(),
                                onChanged: (phone) {
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
                            visible: controller.wrongTry == 1,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getOtp();
                                  Get.to(() => ResetOTPScreen());
                                },
                                child: Text(
                                  "هل نسيت كلمة المرور؟  ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.phone.text.length > 3,
                            child: ElevatedBtn(
                              color: kPrimaryColor,
                              fontSize: 16.sp,
                              textColor: Colors.white,
                              text: "تسجيل الدخول",
                              press: () async {
                                print(controller.phone.text);
                                if (await ConnectivityCheck.checkConnect() ==
                                    false) {
                                  controller.noInternet(context, size);
                                } else {
                                  controller.doLogin();
                                }
                              },
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          AlreadyHaveAnAccountCheck(
                            press: () {
                              Get.off(() => SignUpScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
