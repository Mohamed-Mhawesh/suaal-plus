import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/theme/constants.dart';

import '../../controllers/quiz_controller.dart';



class IndividuallyProgressTimer extends StatelessWidget {
  IndividuallyProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
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
