import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/avatar_model.dart';
import 'package:suaal_plus/models/user_model.dart';
import 'package:suaal_plus/services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import 'package:suaal_plus/view/otp/otp_screen.dart';
import '../helpers/connectivity_check.dart';
import '../models/university_model.dart';
import '../services/home_services.dart';
import '../services/university_services.dart';
import '../theme/constants.dart';
import '../view/Components/no_internet_dialog.dart';
import '../view/Signup/signup_screen2.dart';

class SignupController extends GetxController {
  bool isPasswordShow = false;
  var privacyText = "";
  List<Avatar> avatars = [];
  String chosenAvatar = "";
  String correctOtp = "";
  String userOtp = "";
  int otpResendTimes = 0;

  ScrollController signUpScrollController = ScrollController();
  bool isLoading = false;
  bool isConnected = false;
  bool isAvatarLoading = false;
  final storage = const FlutterSecureStorage();

  //to remove validation error after first try
  var usernameCheckMessage = "";
  var phoneCheckMessage = "";
  AutovalidateMode? autoValidateMode1 = AutovalidateMode.disabled;
  AutovalidateMode? autoValidateMode2 = AutovalidateMode.disabled;

  GlobalKey<FormState> formState1 =
      GlobalKey<FormState>(); //username&phone%password
  GlobalKey<FormState> formState2 = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController firstname;
  late TextEditingController lastname;

  // late TextEditingController email;
  List<University> university = [];
  List<University> activeUniversity = [];

  //to send data
  int graduated = 0;
  String chosenPCountry = "🇸🇾    Syria";
  String city = "";
  String learningType = "عام";
  int universityID = 1;
  int studyYear = 1;

  //to choose
  int chosenCity = 1;
  int chosenLearningType = 1;

  chooseAvatar(String avatar) {
    chosenAvatar = avatar;

    update();
  }

  void showHidePassword() {
    if (isPasswordShow == false) {
      isPasswordShow = true;
      update();
    } else {
      isPasswordShow = false;
      update();
    }
  }

  void choose(String process, int chipId) {
    if (process == "gr") {
      switch (chipId) {
        case 0:
          {
            graduated = 0;
            studyYear = 1;
            update();
          }
          break;
        case 1:
          {
            graduated = 1;
            learningType = "متخرج";
            universityID = 3;
            studyYear = 5;
            update();
          }
          break;

        default:
          {
            graduated = 0;
            update();
          }
      }
    }
    if (process == "ci") {
      switch (chipId) {
        case 1:
          {
            city = "دمشق";
            chosenCity = 1;
            update();
          }
          break;
        case 2:
          {
            city = "ريف دمشق";
            chosenCity = 2;
            update();
          }
          break;
        case 3:
          {
            city = "حلب";
            chosenCity = 3;
            update();
          }
          break;
        case 4:
          {
            city = "حمص";
            chosenCity = 4;
            update();
          }
          break;
        case 5:
          {
            city = "حماة";
            chosenCity = 5;
            update();
          }
          break;
        case 6:
          {
            city = "اللاذقية";
            chosenCity = 6;
            update();
          }
          break;
        case 7:
          {
            city = "إدلب";
            chosenCity = 7;
            update();
          }
          break;
        case 8:
          {
            city = "الحسكة";
            chosenCity = 8;
            update();
          }
          break;
        case 9:
          {
            city = "دير الزور";
            chosenCity = 9;
            update();
          }
          break;
        case 10:
          {
            city = "طرطوس";
            chosenCity = 10;
            update();
          }
          break;
        case 11:
          {
            city = "الرقة";
            chosenCity = 11;
            update();
          }
          break;
        case 12:
          {
            city = "درعا";
            chosenCity = 12;
            update();
          }
          break;
        case 13:
          {
            city = "السويداء";
            chosenCity = 13;
            update();
          }
          break;
        case 14:
          {
            city = "القنيطرة";
            chosenCity = 14;
            update();
          }
          break;
        default:
          {
            city = "دمشق";
            chosenCity = 1;
            update();
          }
      }
    }
    if (process == "le") {
      switch (chipId) {
        case 1:
          {
            learningType = "عام";
            chosenLearningType = 1;
            universityID = 0;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        case 2:
          {
            learningType = "خاص";
            universityID = 0;
            chosenLearningType = 2;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        case 3:
          {
            learningType = "افتراضي";
            universityID = 0;
            chosenLearningType = 3;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        case 4:
          {
            learningType = "مفتوح";
            universityID = 0;
            chosenLearningType = 4;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
          break;
        default:
          {
            learningType = "عام";
            universityID = 0;
            chosenLearningType = 1;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            update();
          }
      }
    }
    if (process == "un") {
      for (var i in university) {
        if (i.id == chipId) {
          universityID = i.id;
          update();
        }
      }
    }
    if (process == "st") {
      switch (chipId) {
        case 1:
          {
            studyYear = 1;
            update();
          }
          break;
        case 2:
          {
            studyYear = 2;
            update();
          }
          break;
        case 3:
          {
            studyYear = 3;
            update();
          }
          break;
        case 4:
          {
            studyYear = 4;
            update();
          }
          break;
        default:
          {
            studyYear = 1;
            update();
          }
      }
    }
  }

  getUniversity() async {
    isLoading = true;
    update();
    try {
      var universityData = await UniversityServices.universityRequest();
      for (Map<String, dynamic> i in universityData) {
        //print (jsonDecode(i.toString()));

        university.add(University.fromJson(i));
      }
      activeUniversity.addAll(
          university.where((element) => element.learningType == learningType));
      update();
    } finally {
      checkInternet();
      isLoading = false;
      update();
    }

    update();
  }

  checkUsername(username) async {
    try {
      var res = await AuthServices.checkUsername(username);

      usernameCheckMessage = res.toString();
      update();
    } catch (e) {
      print(e);
    }
  }

  checkPhone(phone) async {
    try {
      var res = await AuthServices.checkPhone(phone);

      phoneCheckMessage = res.toString();
      update();
    } catch (e) {
      print(e);
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

//to validate username, phone and password and go to screen tow after that
  void goToSignUp2() async {
    isLoading = true;
    update();
    await getAvatars();
    var formData1 = formState1.currentState;
    if (formData1!.validate()) {
      Get.to(() => SignUpScreen2());
    } else {
      autoValidateMode1 = AutovalidateMode
          .onUserInteraction; //to remove validation error after first try
      update();
    }
    checkInternet();
    isLoading = false;

    update();
  }

//to finish sign up
  void doSignup() async {
    isLoading = true;
    update();
    var formData2 = formState2.currentState;
    if (formData2!.validate()) {
      if (universityID != 0) {
        if (chosenAvatar != "") {
          if (otpResendTimes < 3) {
            checkInternet();
            await getOtp();
            Get.to(() => OTPScreen());
          } else {
            showGetSnackBar(
                type: "warning",
                title:
                    "انتهت محاولات إعادة إرسال الكود الخاصة بك، حاول لاحقًا من فضلك.. ");
          }
        } else {
          signUpScrollController.animateTo(
              signUpScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 3000),
              curve: Curves.ease);

          showGetSnackBar(type: "warning", title: "اختر صورة رمزية من فضلك..");
        }
      } else {
        showGetSnackBar(type: "warning", title: "اختر جامعتك من فضلك.. ");
      }
    } else {
      autoValidateMode2 = AutovalidateMode
          .onUserInteraction; //to remove validation error after first try
      showGetSnackBar(
          type: "warning", title: "املأ الحقول المطلوبة بشكل صحيح من فضلك ");
      signUpScrollController.animateTo(
          signUpScrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 3000),
          curve: Curves.ease);
      update();
    }
    isLoading = false;
    update();
  }

  void successSignUp() async {
    isLoading = true;
    update();
    if (userOtp == correctOtp) {
      try {
        var data = await AuthServices.signup(
            username.text,
            phone.text,
            password.text,
            firstname.text,
            lastname.text,
            graduated.toString(),
            chosenPCountry,
            city,
            learningType,
            universityID.toString(),
            studyYear.toString(),
            chosenAvatar);

        if (data != null) {
          var userData = {
            "message": data["message"],
            "token": data["token"],
            "userId": data["userId"],
            "avatar": chosenAvatar,
            "first_name": firstname.text,
            "last_name": lastname.text,
            "username": username.text,
            "phone": phone.text,
            "country": chosenPCountry,
            "city": city,
            "role": data["role"],
            "graduated": graduated,
            "university_id": universityID,
            "study_year": studyYear,
            "learning_type": learningType,
            "status": data["status"],
            "answered_questions": data["answered_questions"],
            "correct_questions": data["correct_questions"],
          };

          var user = userFromJson(jsonEncode(userData));

//store username and token in the device
          await storage.write(key: "username", value: user.username);
          await storage.write(key: 'userId', value: user.userId.toString());
          await storage.write(key: "token", value: user.token);
          await storage.write(key: "first_name", value: user.firstName);
          await storage.write(key: "last_name", value: user.lastName);
          await storage.write(key: "avatar", value: user.avatar);
          await storage.write(key: "phone", value: user.phone);
          await storage.write(key: "password", value: password.text);
          await storage.write(key: "country", value: chosenPCountry);
          await storage.write(key: "city", value: city);
          await storage.write(key: "role", value: user.role);
          await storage.write(
              key: "graduated", value: user.graduated.toString());
          await storage.write(
              key: "university_id", value: user.universityId.toString());
          await storage.write(
              key: "study_year", value: user.studyYear.toString());
          await storage.write(key: "learning_type", value: user.learningType);
          await storage.write(key: "isLogIn", value: "true");
          Get.offAll(() => const HomePage());
        } else {}
      } finally {
        checkInternet();
        isLoading = false;
        update();
      }
    } else if (userOtp.length != 6 || userOtp != correctOtp) {
      showGetSnackBar(
          type: "warning", title: " تأكد من إدخال رمز التفعيل بشكل صحيح");
    }
    isLoading = false;
    update();
  }

  changeOtp(value) {
    userOtp = value;
    update();
  }

  getAvatars() async {
    isAvatarLoading = true;
    update();
    try {
      var data = await AuthServices.avatar();
      for (Map<String, dynamic> i in data) {
        avatars.add(Avatar.fromJson(i));
      }
    } finally {
      isAvatarLoading = false;
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
    checkInternet();
    getUniversity();
    getPrivacyData();
    username = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();

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
