import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/splash_controller.dart';
import '../../theme/constants.dart';
import '../Components/elevated_btn.dart';

class UpdateAppScreen extends StatelessWidget {
  UpdateAppScreen({Key? key}) : super(key: key);
  final SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: GetBuilder<SplashController>(builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Lottie.asset("assets/images/effect.json"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "أهلًا  بك",
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: kSecondColor),
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    width: size.width * 0.6,
                    height: size.height * 0.4,
                  ),
                  Text(
                    "أصبحت هذه النسخة من التطبيق قديمة",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: kSecondColor),
                  ),
                  Text(
                    "قم بتحميل النسخة الجديدة وتابع تجربتك المميزة",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: kSecondColor),
                  ),
                  ElevatedBtn(
                    color: kPrimaryColor,
                    fontSize: 16.sp,
                    textColor: Colors.white,
                    text: "تحد يث",
                    press: () {},
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    ));
  }
}
