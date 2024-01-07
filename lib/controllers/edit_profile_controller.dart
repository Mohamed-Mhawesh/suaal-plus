import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/services/edit_services.dart';

import 'package:suaal_plus/view/home/home_page.dart';

import '../helpers/connectivity_check.dart';
import '../models/avatar_model.dart';
import '../models/university_model.dart';
import '../services/auth_services.dart';
import '../services/university_services.dart';
import '../theme/constants.dart';
import '../view/Components/no_internet_dialog.dart';

class EditProfileController extends GetxController {
  bool isDoingEdits = false;
  bool isPasswordShow = false;
  bool isCurrentPasswordShow = false;
  bool areEditsValid = false;
  bool isPasswordCorrect = true;
  List<Avatar> avatars = [];
  String chosenAvatar = "";
  bool isAvatarLoading = false;
  List<University> university = [];
  List<University> activeUniversity = [];

  bool isLoading = false;
  bool isConnected = false;
  final storage = const FlutterSecureStorage();
  ScrollController editProfileScrollController = ScrollController();

  //to remove validation error after first try
  var usernameCheckMessage = "";
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;

  GlobalKey<FormState> formState =
      GlobalKey<FormState>(); //username&phone&password

  var userId = 0;
  var userToken = "";
  var stringStudyYear = "";
  var storageCurrentPassword = "";
  var storageCurrentUsername = "";

  //to check if current password is true or false
  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController newPassword;
  late TextEditingController currentPassword;
  late TextEditingController firstname;
  late TextEditingController lastname;

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
      isLoading = false;
      update();
    }

    update();
  }

  getCurrentUserInfo() async {
    isLoading = true;
    update();
    try {
      username.text = (await storage.read(key: "username")).toString();
      storageCurrentUsername = (await storage.read(key: "username")).toString();
      userId = int.parse(await storage.read(key: 'userId') ?? "");
      userToken = (await storage.read(key: "token")).toString();
      firstname.text = (await storage.read(key: "first_name")).toString();
      lastname.text = (await storage.read(key: "last_name")).toString();
      phone.text = (await storage.read(key: "phone")).toString();
      storageCurrentPassword = (await storage.read(key: "password")).toString();
      chosenPCountry = (await storage.read(key: "country")).toString();
      city = (await storage.read(key: "city")).toString();
      chosenAvatar = await storage.read(key: "avatar") ?? "";

      graduated = int.parse(await storage.read(key: "graduated") ?? "0");
      universityID = int.parse(await storage.read(key: "university_id") ?? "1");
      studyYear = int.parse(await storage.read(key: "study_year") ?? "1");
      learningType = await storage.read(key: "learning_type") ?? "عام";

      switch (learningType) {
        case "عام":
          {
            chosenLearningType = 1;
          }
          break;
        case "خاص":
          {
            chosenLearningType = 2;
          }
          break;
        case "افتراضي":
          {
            chosenLearningType = 3;
          }
          break;
        case "مفتوح":
          {
            chosenLearningType = 4;
          }
          break;
      }
      switch (city) {
        case "دمشق":
          {
            chosenCity = 1;
          }
          break;
        case "ريف دمشق":
          {
            chosenCity = 2;
          }
          break;
        case "حلب":
          {
            chosenCity = 3;
          }
          break;
        case "حمص":
          {
            chosenCity = 4;
          }
          break;
        case "حماة":
          {
            chosenCity = 5;
          }
          break;
        case "اللاذقية":
          {
            chosenCity = 6;
          }
          break;
        case "إدلب":
          {
            chosenCity = 7;
          }
          break;
        case "الحسكة":
          {
            chosenCity = 8;
          }
          break;
        case "دير الزور":
          {
            chosenCity = 9;
          }
          break;
        case "طرطوس":
          {
            chosenCity = 10;
          }
          break;
        case "الرقة":
          {
            chosenCity = 11;
          }
          break;
        case "درعا":
          {
            chosenCity = 12;
          }
          break;
        case "السويداء":
          {
            chosenCity = 13;
          }
          break;
        case "القنيطرة":
          {
            chosenCity = 14;
          }
          break;
      }
      //to the top info
      switch (studyYear) {
        case 1:
          {
            stringStudyYear = "السنة الأولى";
            update();
          }
          break;
        case 2:
          {
            stringStudyYear = "السنة الثانية";
            update();
          }
          break;
        case 3:
          {
            stringStudyYear = "السنة الثالثة";
            update();
          }
          break;
        case 4:
          {
            stringStudyYear = "السنة الرابعة";
            update();
          }
          break;
        default:
          {
            stringStudyYear = "";
          }
      }

      update();
    } finally {
      isLoading = false;
      update();
    }
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

  void showHidePassword() {
    if (isPasswordShow == false) {
      isPasswordShow = true;
      update();
    } else {
      isPasswordShow = false;
      update();
    }
  }

  void showHideCurrentPassword() {
    if (isCurrentPasswordShow == false) {
      isCurrentPasswordShow = true;
      update();
    } else {
      isCurrentPasswordShow = false;
      update();
    }
  }

  getAvatars() async {
    isAvatarLoading = true;
    update();
    try {
      var data = await EditServices.avatar();
      for (Map<String, dynamic> i in data) {
        avatars.add(Avatar.fromJson(i));
      }
    } finally {
      isAvatarLoading = false;
      update();
    }
  }

  void choose(String process, int chipId) async {
    if (process == "gr") {
      switch (chipId) {
        case 0:
          {
            graduated = 0;
            studyYear = 1;
            learningType =
                (await storage.read(key: "learning_type") ?? "عام") == "متخرج"
                    ? "عام"
                    : await storage.read(key: "learning_type") ?? "عام";
            universityID =
                int.parse(await storage.read(key: "university_id") ?? "1") == 3
                    ? 1
                    : int.parse(
                        await storage.read(key: "university_id") ?? "1");
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
            universityID =
                int.parse(await storage.read(key: "university_id") ?? "1") == 3
                    ? 1
                    : int.parse(
                        await storage.read(key: "university_id") ?? "1");
            update();
          }
          break;
        case 2:
          {
            learningType = "خاص";
            chosenLearningType = 2;
            universityID = 0;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            universityID =
                int.parse(await storage.read(key: "university_id") ?? "1") == 3
                    ? 1
                    : int.parse(
                        await storage.read(key: "university_id") ?? "1");
            update();
          }
          break;
        case 3:
          {
            learningType = "افتراضي";
            chosenLearningType = 3;
            universityID = 0;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            universityID =
                int.parse(await storage.read(key: "university_id") ?? "1") == 3
                    ? 1
                    : int.parse(
                        await storage.read(key: "university_id") ?? "1");
            update();
          }
          break;
        case 4:
          {
            learningType = "مفتوح";
            chosenLearningType = 4;
            universityID = 0;
            activeUniversity.clear();
            activeUniversity.addAll(university
                .where((element) => element.learningType == learningType));
            universityID =
                int.parse(await storage.read(key: "university_id") ?? "1") == 3
                    ? 1
                    : int.parse(
                        await storage.read(key: "university_id") ?? "1");
            update();
          }
          break;
        default:
          {
            learningType = "عام";
            chosenLearningType = 1;
            universityID = 0;
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

  saveEdits() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (universityID != 0) {
        areEditsValid = true;

        update();
      } else {
        showGetSnackBar(type: "warning", title: "اختر جامعتك من فضلك.. ");
      }
    } else {
      areEditsValid = false;
      autoValidateMode = AutovalidateMode
          .onUserInteraction; //to remove validation error after first try
      editProfileScrollController.animateTo(
          editProfileScrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 3000),
          curve: Curves.ease);
      update();
    }
  }

  doEdits() async {
    isPasswordCorrect = true;
    isDoingEdits = true;
    update();
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    var editResponse = await EditServices.editProfileRequest(
        userToken,
        userId.toString(),
        username.text,
        firstname.text,
        lastname.text,
        newPassword.text,
        chosenPCountry,
        city,
        universityID.toString(),
        graduated.toString(),
        studyYear.toString(),
        learningType,
        chosenAvatar);
    if (editResponse.toString() == "success") {
      await storage.write(key: "username", value: username.text);
      await storage.write(key: "first_name", value: firstname.text);
      await storage.write(key: "last_name", value: lastname.text);

      if (newPassword.text.isNotEmpty) {
        await storage.write(key: "password", value: newPassword.text);
      }
      await storage.write(key: "country", value: chosenPCountry);
      await storage.write(key: "city", value: city);
      await storage.write(key: "avatar", value: chosenAvatar);

      await storage.write(key: "graduated", value: graduated.toString());
      await storage.write(key: "university_id", value: universityID.toString());
      await storage.write(key: "study_year", value: studyYear.toString());
      await storage.write(key: "learning_type", value: learningType);

      Get.offAll(() => const HomePage());
    }
    isDoingEdits = false;
    update();
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
    getAvatars();
    username = TextEditingController();
    phone = TextEditingController();
    newPassword = TextEditingController();
    currentPassword = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();
    // email = TextEditingController();
    getCurrentUserInfo();
    checkInternet();

    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    newPassword.dispose();
    currentPassword.dispose();
    firstname.dispose();
    lastname.dispose();
    //email.dispose();
    super.dispose();
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
