import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/constants.dart';

class RoundedPasswordField extends StatelessWidget {

  final Function() showOrHide;
  final Widget icon;
  final bool isObscureText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hint;
  final String? Function(String?) valid;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged, required this.hint, required this.controller, required this.valid, required this.showOrHide, required this.icon, required this.isObscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: 16.h,right: 20.w,left: 20.w),
      child: TextFormField(
        onTap: (){if(controller.selection == TextSelection.fromPosition(TextPosition(offset: controller.text.length -1))){

          controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

        }},
        validator: valid,
        controller: controller,
        style:  inputTextStyle,
        obscureText: isObscureText,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration:  InputDecoration(
          errorStyle: GoogleFonts.cairo(fontSize: 14.sp),

          errorMaxLines: 2,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 20.w),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2.h,
              color: kPrimaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.h,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(
              color: Colors.red,
              width: 1.h,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(
              color: Colors.red,
              width: 2.h,
            ),
          ),


          hintText: hint,
          hintStyle: hintStyle,
          prefixIcon:  Icon(size: 20.h,
            Icons.lock,
            color: Colors.blueGrey,
          ),
          suffixIcon:  IconButton(
            onPressed: showOrHide,

           icon: icon,
            iconSize: 20.h,
            color: Colors.blueGrey,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}