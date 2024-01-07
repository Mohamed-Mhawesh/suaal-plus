import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'elevated_btn.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({
    Key? key,
    required this.size,
    required this.tryAgain,
  }) : super(key: key);

  final Size size;
  final Function() tryAgain;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: size.width * 0.5,
                  child: Lottie.asset("assets/images/internet.json")),
              Text("تحقق من اتصالك بالإنترنت ثم أعد المحاولة من فضلك",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
              ElevatedBtn(
                  fontSize: 14.sp, text: "إعادة المحاولة", press: tryAgain)
            ],
          ),
        ),
      ],
    );
  }
}
