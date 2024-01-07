import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'elevated_btn.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.4,
            child: Lottie.asset("assets/images/internet.json")),
        content: Text("تأكد من اتصالك بالإنترنت ثم أعد المحاولة من فضلك",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
        actions: [
          ElevatedBtn(
              fontSize: 14.sp,
              text: "حسنًا",
              press: () {
                Get.back();
              })
        ],
        actionsAlignment: MainAxisAlignment.center);
  }
}
