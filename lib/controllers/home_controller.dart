import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/advertisement_model.dart';
import 'package:suaal_plus/models/top_ten_model.dart';
import 'package:suaal_plus/view/Welcome/welcome_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/connectivity_check.dart';
import '../theme/constants.dart';
import '../models/subject_model.dart';
import '../services/home_services.dart';
import '../view/Components/no_internet_dialog.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  RxBool isConnected = false.obs;

  bool getUsernameAndStdYearIsLoading = false;
  var inviteText = "";
  var privacyText = "";
  var currentPage = 0;
  int userUniversity = 0;
  final storage = const FlutterSecureStorage();
  String individuallySubId = "";
  String chosenSpecialize = "الكل";
  String userName = "";
  String userAvatar = "";
  String userStudyYear = ""; //to show name of year
  int studyYear = 1; //to send year in the request
  String token = "";
  String userId = "";
  List<Advertisement> advertisementList = [];
  var advertisementImagesList = [];
  List<TopTen> topTenList = [];
  List<Subject> subjectsList = []; //all subjects that comes from response
  List<Subject> activeSubjectList = []; //filtering subjects
  bool isEndSemester = true;
  bool newNotifications = false;
  int endIn = 0;

  void navigateToPage(int pageIndex) {
    currentPage = pageIndex;
    update();
  }

  void chooseSpecialize(String chipId) {
    switch (chipId) {
      case "الكل":
        {
          chosenSpecialize = "الكل";
          update();
        }
        break;
      case "مدني":
        {
          chosenSpecialize = "مدني";
          update();
        }
        break;
      case "جزائي":
        {
          chosenSpecialize = "جزائي";
          update();
        }
        break;
      case "دولي":
        {
          chosenSpecialize = "دولي";
          update();
        }
        break;
      case "إداري":
        {
          chosenSpecialize = "إداري";
          update();
        }
        break;
      case "تجاري":
        {
          chosenSpecialize = "تجاري";
          update();
        }
        break;
      case "احوال شخصية ":
        {
          chosenSpecialize = "احوال شخصية ";
          update();
        }
        break;
      case "اضافي":
        {
          chosenSpecialize = "اضافي";
          update();
        }
        break;
      default:
        {
          chosenSpecialize = "الكل";
          update();
        }
    }
  }

  Color chosenColor(String chipId) {
    if (chosenSpecialize == chipId) {
      return kPrimaryColor;
    } else {
      return Colors.white;
    }
  }

  Color chosenTextColor(String chipId) {
    if (chosenSpecialize == chipId) {
      return Colors.white;
    } else {
      return kPrimaryColor;
    }
  }

  chosenShadowColor(id) {
    switch (id) {
      case "مدني":
        {
          return const Color(0xffa4f5a6);
        }
      case "جزائي":
        {
          return const Color(0xfffdfca4);
        }
      case "دولي":
        {
          return const Color(0xffa6a7f8);
        }
      case "إداري":
        {
          return const Color(0xffffb5b8);
        }
      case "تجاري":
        {
          return const Color(0xff99f6fd);
        }
      case "احوال شخصية ":
        {
          return const Color(0xffffe2fe);
        }
      case "اضافي":
        {
          return const Color(0xff9bf5fd);
        }
      default:
        {
          return const Color(0xffadf7b1);
        }
    }
  }

  specializeIcon(id) {
    switch (id) {
      case "مدني":
        {
          return "s1.png";
        }
      case "جزائي":
        {
          return "s2.png";
        }
      case "دولي":
        {
          return "s3.png";
        }
      case "إداري":
        {
          return "s4.png";
        }
      case "تجاري":
        {
          return "s5.png";
        }
      case "احوال شخصية ":
        {
          return "s6.png";
        }
      case "اضافي":
        {
          return "s7.png";
        }
      default:
        {
          return "s1.png";
        }
    }
  }

  specializeColor(id) {
    switch (id) {
      case "مدني":
        {
          return [
            const Color(0xffa4f5a6),
            const Color(0xffa4f5a6).withOpacity(0.9)
          ];
        }
      case "جزائي":
        {
          return [
            const Color(0xfffdfca4),
            const Color(0xfffdfca4).withOpacity(0.9)
          ];
        }
      case "دولي":
        {
          return [
            const Color(0xffa6a7f8),
            const Color(0xffa6a7f8).withOpacity(0.9)
          ];
        }
      case "إداري":
        {
          return [
            const Color(0xffffb5b8),
            const Color(0xffffb5b8).withOpacity(0.9)
          ];
        }
      case "تجاري":
        {
          return [
            const Color(0xffFD841F),
            const Color(0xffFD841F).withOpacity(0.9)
          ];
        }
      case "احوال شخصية ":
        {
          return [
            const Color(0xffffe2fe),
            const Color(0xffffe2fe).withOpacity(0.9)
          ];
        }
      case "اضافي":
        {
          return [
            const Color(0xff9bf5fd),
            const Color(0xff9bf5fd).withOpacity(0.9)
          ];
        }
      default:
        {
          return [
            const Color(0xffadf7b1),
            const Color(0xffadf7b1).withOpacity(0.9)
          ];
        }
    }
  }

  seeAll(int newPage) {
    currentPage = newPage;
    update();
  }

  phoneCallLaunch(number) async {
    if (await canLaunchUrl(Uri.parse('tel://$number'))) {
      await launch('tel://$number');
    }
  }

  facebookUrlLaunch(id) async {
    if (await canLaunchUrl(Uri.parse('fb://$id'))) {
      await launch('fb://$id');
    }
  }

  whatsappUrlLaunch(number) async {
    if (await canLaunchUrl(Uri.parse("https://wa.me/+963$number/"))) {
      await launch("https://wa.me/+963$number/");
    }
  }

  telegramUrlLaunch(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launch(url);
    }
  }

  // setRecentSubjects(subId)async{
  //
  //   await storage.write(key: 'recent1', value: subId.toString());
  //
  //
  //
  //
  //
  //
  //   update();
  // }

  setIndividuallySubId(subId, subName, subYear) async {
    await storage.write(key: 'individuallySubId', value: subId.toString());
    await storage.write(key: 'individuallySubName', value: subName.toString());
    await storage.write(key: 'individuallySubYear', value: subYear.toString());
    update();
  }

  getUserNameAndStudyYearAndAvatar() async {
    try {
      getUsernameAndStdYearIsLoading = true;
      String? value = (await storage.read(key: 'username'));
      String? value1 = (await storage.read(key: 'study_year'));
      String? value2 = (await storage.read(key: 'avatar'));
      userName = value ?? "";
      userAvatar = value2 ?? "";
      switch (value1) {
        case "1":
          {
            userStudyYear = "السنة الأولى";
            studyYear = 1;
            update();
          }
          break;
        case "2":
          {
            userStudyYear = "السنة الثانية";
            studyYear = 2;
            update();
          }
          break;
        case "3":
          {
            userStudyYear = "السنة الثالثة";
            studyYear = 3;
            update();
          }
          break;
        case "4":
          {
            userStudyYear = "السنة الرابعة";
            studyYear = 4;
            update();
          }
          break;
        case "5":
          {
            userStudyYear = "متخرج";
            studyYear = 5;
            update();
          }
          break;
        default:
          {
            userStudyYear = "";
          }
      }
      value1 ?? "";
      update();
    } finally {
      getUsernameAndStdYearIsLoading = false;
      update();
    }
  }

  getUserToken() async {
    String? value = (await storage.read(key: 'token'));
    String? value1 = (await storage.read(key: 'university_id'));
    String? userIdValue = (await storage.read(key: 'userId'));

    if (value != null) {
      token = value;
    }
    if (value1 != null) {
      userUniversity = int.parse(value1);
    }
    if (userIdValue != null) {
      userId = userIdValue;
    }
    update();
  }

  getHomeDetails() async {
    isLoading(true);
    Map<String, String> allValues = await storage.readAll();
    await getUserToken();
    await getUserNameAndStudyYearAndAvatar();
    try {
      var homeData = await HomeServices.mainRequest(
          token, userId, studyYear, userUniversity);

      for (Map<String, dynamic> i in homeData[0]) {
        advertisementList.add(Advertisement.fromJson(i));
      }
      advertisementList.forEach((element) {
        advertisementImagesList.add(element.img);
      });

      for (Map<String, dynamic> i in homeData[1]) {
        topTenList.add(TopTen.fromJson(i));
      }

      for (Map<String, dynamic> i in homeData[2]) {
        subjectsList.add(Subject.fromJson(i));
      }
      activeSubjectList.addAll(subjectsList);

      isEndSemester = homeData[3];
      newNotifications = homeData[4];
      endIn = homeData[5];
    } catch (w) {
      print("home Error $w");
    } finally {
      if (isEndSemester) {
        try {
          var afterNintyData = await HomeServices.afterNinty(token, userId);
        } catch (e) {
        } finally {}
      }
      checkInternet();
      isLoading(false);
      update();
    }
  }

  filterSubjects(String specialize) {
    activeSubjectList.clear();
    if (specialize == "الكل") {
      activeSubjectList.addAll(subjectsList);
      update();
    }

    {
      activeSubjectList.addAll(subjectsList
          .where((element) => element.specializeName == specialize));
      update();
    }
  }

  logout() async {
    await storage.delete(key: "username");
    await storage.delete(key: 'userId');
    await storage.delete(key: "token");
    await storage.delete(key: "first_name");
    await storage.delete(key: "last_name");
    await storage.delete(key: "phone");
    await storage.delete(key: "password");
    await storage.delete(key: "country");
    await storage.delete(key: "city");
    await storage.delete(key: "role");
    await storage.delete(key: "graduated");
    await storage.delete(key: "university_id");
    await storage.delete(key: "study_year");
    await storage.delete(key: "learning_type");
    await storage.delete(key: "isLogIn");
    Get.offAll(() => const WelcomeScreen());
  }

  getInviteData() async {
    try {
      var inviteData = await HomeServices.inviteRequest(token);
      inviteText = inviteData.toString();
      update();
    } finally {
      checkInternet();
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
      isConnected(true);
    } else {
      isConnected(false);
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
    getHomeDetails();
    getInviteData();
    getPrivacyData();
    checkInternet();

    super.onInit();
  }
}
