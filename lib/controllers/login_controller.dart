import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/services/auth_services.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Welcome/welcome_screen.dart';

import '../helpers/connectivity_check.dart';
import '../services/home_services.dart';
import '../view/Components/no_internet_dialog.dart';
import '../view/home/home_page.dart';
import '../view/reset_password/reset_password_screen.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  GlobalKey<FormState> formState1 = GlobalKey<FormState>();
  bool isPasswordShow = false;
  bool isLoading = false;
  bool isConnected = false;
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;
  AutovalidateMode? autoValidateMode1 = AutovalidateMode.disabled;
  final storage = const FlutterSecureStorage();
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController newPassword;
  var privacyText = "";
  String correctOtp = "";
  String userOtp = "";
  int otpResendTimes = 0;

  int wrongTry = 0;
  String internetConnect = "";

  void showHidePassword() {
    if (isPasswordShow == false) {
      isPasswordShow = true;
      update();
    } else {
      isPasswordShow = false;
      update();
    }
  }

  getOtp() async {
    isLoading = true;
    update();
    try {
      var data = await AuthServices.otp(phone.text);
      correctOtp = data.toString();
      userOtp = "";
      update();
    } finally {
      if (otpResendTimes > 0 && correctOtp.length == 6) {
        showGetSnackBar(
            type: "success", title: "تمت إعادة إرسال كود التفعيل إلى هاتفك.. ");
      }
      isLoading = false;
      update();
    }
  }

  resendOtp() async {
    otpResendTimes += 1;
    await getOtp();
  }

  resetPassword() async {
    isLoading = true;
    update();
    var formData1 = formState1.currentState;
    if (formData1!.validate()) {
      try {
        var resetData =
            await AuthServices.resetPassword(phone.text, newPassword.text);
        if (resetData == "success") {
          showGetSnackBar(
              type: "success",
              title:
                  "تم إعادة تعيين كلمة المرور بنجاح،\n يمكنك استخدامها لتسجيل الدخول ");
          Get.offAll(() => const WelcomeScreen());
        } else {
          showGetSnackBar(
              type: "warning", title: "حدث خطأ ما، تأكد من اتصالك بالإنترنت ");
        }
      } finally {
        isLoading = false;
        update();
      }
    } else {
      autoValidateMode1 = AutovalidateMode
          .onUserInteraction; //to remove validation error after first try
      update();
    }
  }

  goToResetPasswordScreen() {
    if (userOtp == correctOtp) {
      Get.off(() => ResetPasswordScreen());
    } else {
      showGetSnackBar(
          type: "warning", title: " تأكد من إدخال رمز التفعيل بشكل صحيح");
    }
  }

  changeOtp(value) {
    userOtp = value;
    update();
  }

  void doLogin() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      isLoading = true;
      update();
      try {
        //send request to the server and receive response that contains user information
        var data = await AuthServices.login(phone.text, password.text);

        if (data != null) {
          if (data.message == "Success") {
//store username and token in the device
            await storage.write(key: "username", value: data.username);
            await storage.write(key: "userId", value: data.userId.toString());
            await storage.write(key: "token", value: data.token);
            await storage.write(key: "first_name", value: data.firstName);
            await storage.write(key: "last_name", value: data.lastName);
            await storage.write(key: "avatar", value: data.avatar);
            await storage.write(key: "phone", value: data.phone);
            await storage.write(key: "password", value: password.text);
            await storage.write(key: "country", value: data.country);
            await storage.write(key: "city", value: data.city);
            await storage.write(key: "role", value: data.role);
            await storage.write(
                key: "graduated", value: data.graduated.toString());
            await storage.write(
                key: "university_id", value: data.universityId.toString());
            await storage.write(
                key: "study_year", value: data.studyYear.toString());
            await storage.write(key: "learning_type", value: data.learningType);
            await storage.write(key: "isLogIn", value: "true");

            Get.offAll(() => const HomePage());
          } else if (data.message == "Password not matched") {
            wrongTry = 1;
            update();
            showGetSnackBar(type: "warning", title: "كلمة المرور خاطئة ");
          }
        } else {
          await checkInternet();
          if (isConnected) {
            showGetSnackBar(type: "warning", title: "رقم الهاتف غير صحيح");
          } else {
            showGetSnackBar(
                type: "warning", title: "تحقق من اتصالك  بالإنترنت");
          }
        }
      } finally {
        isLoading = false;
        update();
      }
    } else {
      autoValidateMode = AutovalidateMode
          .onUserInteraction; //to remove validation error after first try
      update();
    }
  }

  getPrivacyData() async {
    try {
      var privacyData = await HomeServices.privacyRequest();
      privacyText = privacyData.toString();
      update();
    } finally {
      checkInternet();
    }
  }

  checkInternet() async {
    if (await ConnectivityCheck.checkConnect() == true) {
      isConnected = true;
      update();
    } else {
      isConnected = false;
      update();
    }
  }

  void noInternet(BuildContext context, Size size) {
    showNoInternetDialog(context, size);
  }

  Future<dynamic> showNoInternetDialog(BuildContext context, Size size) {
    return showDialog(
        context: context, builder: (context) => const NoInternetDialog());
  }

  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    newPassword = TextEditingController();
    super.onInit();
  }
}

SnackbarController showGetSnackBar(
    {required String type, required String title}) {
  return Get.snackbar(
    "",
    "",
    titleText: Row(
      children: [
        Icon(
          type == "success" ? Icons.check_circle : Icons.warning_rounded,
          color: Colors.white,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          title,
          style: subjectNameTextStyle,
        ),
      ],
    ),
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    backgroundColor:
        type == "success" ? const Color(0xff55a630) : const Color(0xfffecf3e),
    colorText: Colors.white,
    messageText: const SizedBox(),
    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
  );
}
