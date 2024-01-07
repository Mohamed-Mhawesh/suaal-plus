import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';

import '../models/on_boarding_model.dart';
import '../view/Welcome/welcome_screen.dart';

class OnBoardingController extends GetxController {
  final storage = const FlutterSecureStorage();

  List<onbordingScreenModel> onBoardingScreens = [
    onbordingScreenModel(
        img: "assets/images/l1.json",
        title: 'اختبر نفسك أين ما كنت',
        subTitle:
            "يمكنك من خلال تطبيق Suaal Plus اختبار معلوماتك وخوض التجربة الإمتحانية في أي زمان ومكان"),
    onbordingScreenModel(
        img: "assets/images/l3.json",
        title: 'نافس أصدقائك',
        subTitle: "عِش شعور المنافسة وأجوائها مع أصدقائك وكُن من المتميزين"),
  ];

  PageController? pageController;

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    update();
  }

  void onNextPressed() {
    if (currentIndex == onBoardingScreens.length - 1) {
      storage.write(key: "isNotFirstTime", value: "true");

      Get.to(const WelcomeScreen());
    }
    pageController!.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }

  Color getColor(index) {
    if (currentIndex == index) return Colors.white;
    return Colors.white70;
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController!.dispose();
    super.onClose();
  }
}
