import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/view/Components/simple_shadow.dart';

class AnswerOption extends StatelessWidget {
  const AnswerOption({
    Key? key,
    required this.text,
    required this.index,
    required this.questionId,
    required this.color,
    required this.textcolor,
    required this.strindex,
  }) : super(key: key);

  final String text;
  final int index;
  final int questionId;
  final color;
  final textcolor;
  final strindex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SimpleShadow(
      color: Colors.grey,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.04),
          child: SizedBox(
            //width: size.width*0,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "$strindex $text",
                maxLines: 5,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.sp, color: textcolor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerIndexOption extends StatelessWidget {
  const AnswerIndexOption({
    Key? key,
    required this.index,
    required this.questionId,
    required this.onPressed,
    required this.color,
    required this.textcolor,
    required this.strindex,
  }) : super(key: key);

  final int index;
  final int questionId;
  final Function() onPressed;
  final color;
  final textcolor;
  final strindex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap:

          onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 8.w),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            color: color,
            shape: BoxShape.circle),
        child: Text(
          strindex,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: textcolor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
