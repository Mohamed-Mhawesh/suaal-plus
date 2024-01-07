import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/constants.dart';

class ElevatedBtn extends StatelessWidget {
  final Color? color, textColor;
  final String text;
  final double fontSize;
  final void Function() press;

  const ElevatedBtn({
    Key? key,
    this.color = kPrimaryColor,
    required this.fontSize,
    required this.text,
    required this.press,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          textStyle: GoogleFonts.cairo(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w800),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 14.sp),
        ),
      ),
    );
  }
}
