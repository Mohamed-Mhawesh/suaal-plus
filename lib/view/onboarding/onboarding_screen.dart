import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:suaal_plus/view/Components/simple_shadow.dart';

import '../../controllers/on_boarding_controller.dart';
import '../../theme/constants.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<OnBoardingController>(
          init: OnBoardingController(),
          builder: (controller) => Container(
            height: size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kPrimaryColor.withOpacity(0.7), kPrimaryColor],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) => controller.changeIndex(index),
                    itemCount: controller.onBoardingScreens.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.05,
                            horizontal: size.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: size.height * 0.4,
                                child: SimpleShadow(
                                    offset: const Offset(2, 6),
                                    child: Lottie.asset(controller
                                        .onBoardingScreens[index].img))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.onBoardingScreens[index].title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Text(
                                  controller.onBoardingScreens[index].subTitle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.onNextPressed();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.height * 0.03,
                            horizontal: size.width * 0.1),
                        width: size.width * 0.12,
                        child: SimpleShadow(
                            child: Image.asset("assets/icons/arrow.png")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.03,
                          horizontal: size.width * 0.1),
                      width: size.width * 0.2,
                      child: SimpleShadow(
                          child: Image.asset("assets/images/whiteLogo.png")),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
