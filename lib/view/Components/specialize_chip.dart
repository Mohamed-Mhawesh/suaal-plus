import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class SpecializeChip extends StatelessWidget {
  HomeController controller = Get.find();

  final String chipText;
  final String chipId;

  SpecializeChip({
    Key? key,
    required this.chipText,
    required this.chipId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        controller.chooseSpecialize(chipId);
        controller.filterSubjects(chipId);
      },
      child: Container(
        height: 30.h,
        width: 100.w,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 2)),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(2, 0)),
          ],
          color: controller.chosenColor(chipId),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 2.h, bottom: 4.h, right: 4.w, left: 4.w),
        child: Center(
            child: Text(
          chipText,
          style: TextStyle(
              fontSize: 12.sp,
              color: controller.chosenTextColor(chipId),
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
