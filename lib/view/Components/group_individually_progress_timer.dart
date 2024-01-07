import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/controllers/group_quiz_controller.dart';
import 'package:suaal_plus/theme/constants.dart';




class GroupIndividuallyProgressTimer extends StatelessWidget {
  GroupIndividuallyProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<GroupQuizController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupQuizController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${controller.minutes}:${controller.seconds}',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: kPrimaryColor),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }
}
