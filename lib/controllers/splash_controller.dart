import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:suaal_plus/services/auth_services.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import 'package:suaal_plus/view/onboarding/onboarding_screen.dart';
import 'package:suaal_plus/view/update_app/update_app_screen.dart';

import '../view/Welcome/welcome_screen.dart';

class SplashController extends GetxController {
  final storage = const FlutterSecureStorage();
  String? version;
  String? isUpToDate = "";
  String? isLoggedIn = "";
  String? isNotFirstTime = "";
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    packageInfo = info;
    printInfo(info: "$packageInfo", printFunction: () {});

    update();
  }

  checkUpdate() async {
    update();

    try {
      var checkUpdateData = await AuthServices.checkUpdate();

      if (checkUpdateData != null) {
        version = checkUpdateData["version"];

        if (packageInfo.version == version) {
          await storage.write(key: "isUpToDate", value: "true");
        } else {
          await storage.write(key: "isUpToDate", value: "false");
        }
        update();
      } else {
        printError(info: 'error in data', logFunction: () {});
      }
    } catch (e) {
      print(e);
    }
  }

  checkUserStatus() async {
    String? isUpToDateValue = (await storage.read(key: 'isUpToDate')) ?? "true";
    String? isLoggedInValue = (await storage.read(key: 'isLogIn')) ?? "false";
    String? isNotFirstTimeValue =
        (await storage.read(key: 'isNotFirstTime')) ?? "false";
    isUpToDate = isUpToDateValue;
    isNotFirstTime = isNotFirstTimeValue;
    isLoggedIn = isLoggedInValue;

    update();
  }

  @override
  void onReady() {
    if (isUpToDate == "false") {
      Future.delayed(const Duration(seconds: 4), () {
        Get.offAll(() => UpdateAppScreen());
      });
    } else {
      if (isLoggedIn == "true") {
        Future.delayed(const Duration(seconds: 4), () {
          Get.offAll(() => const HomePage());
        });
      } else {
        if (isNotFirstTime == "true") {
          Future.delayed(const Duration(seconds: 4), () {
            Get.offAll(() => const WelcomeScreen());
          });
        } else {
          Future.delayed(const Duration(seconds: 4), () {
            Get.offAll(() => const OnBoardingScreen());
          });
        }
      }
    }
    super.onReady();
  }

  @override
  void onInit() async {
    initPackageInfo();
    await checkUpdate();

    await checkUserStatus();

    super.onInit();
  }
}
