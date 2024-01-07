import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controllers/login_controller.dart';
import '../../theme/constants.dart';
import '../Components/elevated_btn.dart';

class ResetOTPScreen extends StatelessWidget {
  ResetOTPScreen({Key? key}) : super(key: key);
  LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: size.height,
        width: double.infinity,
        child: GetBuilder<LoginController>(builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  child: Center(
                      child: Text(
                    "نسيت كلمة المرور",
                    style: GoogleFonts.cairo(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  )),
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.14),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                          topLeft: Radius.circular(120),
                          bottomLeft: Radius.circular(20))),
                  child: SizedBox(
                      width: size.width * 0.7,
                      child: Lottie.asset("assets/images/otp.json")),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text("من فضلك، أدخل رمز التحقق الذي أرسلناه إلى هاتفك",
                    style: GoogleFonts.cairo(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onCompleted: (value) {
                          if (controller.userOtp == controller.correctOtp) {
                            print("correct otp");
                          } else {
                            print("wrong otp");
                          }
                        },
                        onChanged: (String value) {
                          controller.changeOtp(value);
                        },
                        length: 6,
                        appContext: context,
                        cursorColor: kPrimaryColor,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(20),
                          selectedColor: kPrimaryColor,
                          activeColor: kPrimaryColor,
                          inactiveColor: kPrimaryColor.withOpacity(0.14),
                          selectedFillColor: kPrimaryColor.withOpacity(0.14),
                          activeFillColor: kPrimaryColor.withOpacity(0.14),
                          inactiveFillColor: kPrimaryColor.withOpacity(0.14),
                          fieldHeight: 60.h,
                          fieldWidth: 50.w,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.otpResendTimes < 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "إذا لم يصلك أي كود !",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            controller.resendOtp();
                          },
                          child: Text(
                            "إعادة الإرسال",
                            style: GoogleFonts.cairo(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )),
                    ],
                  ),
                ),
                Visibility(
                    visible: controller.isLoading,
                    child: Center(
                      child: SizedBox(
                          width: size.width * 0.2,
                          child: Lottie.asset("assets/images/loading0.json")),
                    )),
                SizedBox(
                    width: size.width * 0.4,
                    child: ElevatedBtn(
                        text: "تأكيد",
                        fontSize: 16.sp,
                        press: () {
                          controller.goToResetPasswordScreen();
                        }))
              ],
            ),
          );
        }),
      ),
    ));
  }
}
