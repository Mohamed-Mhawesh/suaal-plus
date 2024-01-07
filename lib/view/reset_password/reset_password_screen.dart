import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/login_controller.dart';
import '../../theme/constants.dart';
import '../../helpers/valid_input.dart';
import '../Components/elevated_btn.dart';
import '../Components/rounded_password_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.white70,
        child: Form(
          key: controller.formState1,
          autovalidateMode: controller.autoValidateMode1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  child: Center(
                      child: Text(
                    "إعادة تعيين كلمة المرور",
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
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                          topLeft: Radius.circular(120),
                          bottomLeft: Radius.circular(20))),
                  child: SizedBox(
                      width: size.width * 0.7,
                      child: Lottie.asset("assets/images/resetPassword.json")),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Center(
                    child: Text("أدخل كلمة المرور الجديدة من فضلك",
                        style: GoogleFonts.cairo(
                            fontSize: 14.sp, fontWeight: FontWeight.w600))),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedPasswordField(
                  icon: controller.isPasswordShow
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  showOrHide: controller.showHidePassword,
                  isObscureText: !controller.isPasswordShow,
                  valid: (val) {
                    return validInput(val!, 8, 100, "password");
                  },
                  controller: controller.newPassword,
                  hint: "كلمة المرور الجديدة",
                  onChanged: (value) {},
                ),
                ElevatedBtn(
                  color: kPrimaryColor,
                  fontSize: 16.sp,
                  textColor: Colors.white,
                  text: "إعادة تعيين",
                  press: () {
                    controller.resetPassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
