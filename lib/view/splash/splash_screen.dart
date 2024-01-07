import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Stack(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Lottie.asset("assets/images/effect.json"),
              ),
              AnimationLimiter(
                child: AnimationConfiguration.staggeredList(
                  position: 1,
                  duration: const Duration(milliseconds: 2000),
                  child: FadeInAnimation(
                    child: Center(
                        child: SizedBox(
                            width: size.width * 0.6,
                            child: Image.asset("assets/images/logo.png"))),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    ));
  }
}
