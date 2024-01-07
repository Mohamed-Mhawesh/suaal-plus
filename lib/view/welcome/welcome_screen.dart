import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Login/login_screen.dart';
import 'package:suaal_plus/view/Signup/signup_screen.dart';

import '../Components/elevated_btn.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white70),
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Lottie.asset("assets/images/effect.json"),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                        position: 1,
                        duration: const Duration(milliseconds: 3000),
                        child: FadeInAnimation(
                          child: Column(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 1000),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: -100.w,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            ElevatedBtn(
                              color: kPrimaryColor,
                              fontSize: 14.sp,
                              textColor: Colors.white,
                              text: "تسجيل الدخول",
                              press: () {
                                Get.off(() => LoginScreen());
                              },
                            ),
                            ElevatedBtn(
                              color: kSecondColor,
                              fontSize: 14.sp,
                              textColor: Colors.white,
                              text: "إنشاء حساب جديد",
                              press: () {
                                Get.off(() => SignUpScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
