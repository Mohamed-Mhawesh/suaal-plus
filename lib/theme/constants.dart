import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xff7d7eff);
Color kSecondColor = const Color(0xff01004e).withOpacity(0.7);
Color kLightColor = const Color(0xffc5c4ff).withOpacity(0.2);
const kBackgroundColor = Color(0xfffafafa);

TextStyle hintStyle = GoogleFonts.cairo(
    color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.w600);
TextStyle w600TextStyle = GoogleFonts.cairo(
    color: kSecondColor, fontSize: 16.sp, fontWeight: FontWeight.w600);
TextStyle textButtonTextStyle = GoogleFonts.cairo(
    color: kPrimaryColor, fontSize: 16.sp, fontWeight: FontWeight.w700);
TextStyle inputTextStyle = GoogleFonts.cairo(
    color: kPrimaryColor, fontSize: 16.sp, fontWeight: FontWeight.w600);
TextStyle normalTextStyle = GoogleFonts.cairo(
    color: kSecondColor, fontSize: 14.sp, fontWeight: FontWeight.w600);
TextStyle titleTextStyle = GoogleFonts.cairo(
    color: kSecondColor, fontSize: 14.sp, fontWeight: FontWeight.bold);
TextStyle subjectNameTextStyle = GoogleFonts.cairo(
  color: Colors.white,
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
);
TextStyle subjectInfoTextStyle = GoogleFonts.cairo(
  fontSize: 10.sp,
  color: Colors.white,
);
