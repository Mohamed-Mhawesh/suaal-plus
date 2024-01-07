import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final void Function() press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "ليس لديك حساب؟  " : "لديك حساب مسبقًا؟  ",
          style:  w600TextStyle,
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "إنشاء حساب جديد" : "تسجيل الدخول",
            style:  textButtonTextStyle,
          ),
        )
      ],
    );
  }
}