import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suaal_plus/view/Components/simple_shadow.dart';

import '../../theme/constants.dart';

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final String studyYear;
  final String subjectSpecialize;
  final String specializeIcon;
  final List<Color> gradient;
  final Color shadowColor;
  final void Function()? onTap;

  const SubjectCard(
      {Key? key,
      required this.subjectName,
      required this.studyYear,
      required this.subjectSpecialize,
      required this.onTap,
      required this.gradient,
      required this.shadowColor,
      required this.specializeIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SimpleShadow(
      offset: const Offset(0, 0),
      color: kPrimaryColor,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          height: 120.h,
          width: size.width * 0.45,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xff8586ff), Color(0xff8586ff)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: size.height * 0.001),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff000000)
                                        .withOpacity(0.2),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4)
                              ],
                            ),
                            child: SimpleShadow(
                              color: Colors.grey[400]!,
                              child: CircleAvatar(
                                radius: 18.w,
                                backgroundColor: Colors.white,
                                child: SizedBox(
                                  width: 20.w,
                                  child: Image.asset(
                                    'assets/icons/$specializeIcon',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subjectSpecialize,
                                style: subjectInfoTextStyle,
                              ),
                              Text(
                                studyYear,
                                style: subjectInfoTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                        width: size.width * 0.07,
                        child: Image.asset("assets/icons/book.png"),
                      ),
                    ],
                  ),
                  Divider(height: size.height * 0.014),
                ],
              ),
              Text(
                subjectName,
                style: subjectNameTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
