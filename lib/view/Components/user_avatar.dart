import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suaal_plus/view/Components/simple_shadow.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final String imageName;
  final String text;

  const UserAvatar({
    required this.radius,
    required this.imageName,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 100.h,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Column(
          children: [
            SimpleShadow(
              child: SizedBox(
                width: 56.w,
                child:
                    Image.network("https://suaalplus.sy/public/img/$imageName"),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 6.h),
                child: Text(
                    textAlign: TextAlign.center,
                    text,
                    style: GoogleFonts.cairo(
                        height: 1,
                        color: kSecondColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp)))
          ],
        ));
  }
}
