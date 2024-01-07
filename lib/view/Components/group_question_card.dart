import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:suaal_plus/controllers/group_quiz_controller.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Components/simple_shadow.dart';

import '../../models/question_model.dart';
import 'answer_option.dart';

class GroupQuestionCard extends StatelessWidget {
  final QuestionsModel questionsModel;
  final int index;

  const GroupQuestionCard({
    Key? key,
    required this.questionsModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(width: 2, color: kPrimaryColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          child: GetBuilder<GroupQuizController>(
            init: GroupQuizController(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "(اختر ${questionsModel.type})",
                    style: TextStyle(
                        color: kPrimaryColor.withOpacity(0.7), fontSize: 16.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(
                    "${index + 1}. ${questionsModel.title}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                ...List.generate(
                  controller
                      .usedQuestionsAnswers["${questionsModel.id}"]!.length,
                  ((index) {
                    return Column(
                      children: [
                        AnswerOption(
                          questionId: questionsModel.id!,
                          text:
                              "${controller.usedQuestionsAnswers["${questionsModel.id}"]![index]["title"]}",
                          index: index,
                          color: controller.getColor(index, questionsModel.id!),
                          strindex: '${controller.getString(index)}. ',
                          textcolor: controller.getTextColor(
                              index, questionsModel.id!),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                          controller
                              .usedQuestionsAnswers["${questionsModel.id}"]!
                              .length,
                          (index) => AnswerIndexOption(
                              questionId: questionsModel.id!,
                              index: index,
                              color: controller.getColor(
                                  index, questionsModel.id!),
                              strindex: controller.getString(index),
                              textcolor: controller.getTextColor(
                                  index, questionsModel.id!),
                              onPressed: () => Get.find<GroupQuizController>()
                                  .checkAnswer(questionsModel, index)),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "${questionsModel.learning_type}/دورة ${questionsModel.year_time} / "
                      "111${questionsModel.id}#",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupWrongCard extends StatelessWidget {
  final QuestionsModel questionsModel;

  final int index;

  const GroupWrongCard({
    Key? key,
    required this.questionsModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      color: Colors.white70,
      child: Container(
        margin: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 2, color: kPrimaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            child: GetBuilder<GroupQuizController>(
              init: GroupQuizController(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "(اختر ${questionsModel.type})",
                      style: TextStyle(
                          color: kPrimaryColor.withOpacity(0.7),
                          fontSize: 16.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Text(
                      "${index + 1}. ${questionsModel.title}",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...List.generate(
                    controller
                        .usedQuestionsAnswers["${questionsModel.id}"]!.length,
                    ((index) {
                      return Column(
                        children: [
                          AnswerOption(
                            questionId: questionsModel.id!,
                            text:
                                "${controller.usedQuestionsAnswers["${questionsModel.id}"]![index]["title"]}",
                            index: index,
                            color:
                                controller.getColor(index, questionsModel.id!),
                            strindex: '${controller.getString(index)}. ',
                            textcolor: controller.getTextColor(
                                index, questionsModel.id!),
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      );
                    }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "${questionsModel.learning_type}/دورة ${questionsModel.year_time} / "
                        "111${questionsModel.id}#",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GroupQuestionIndex extends StatelessWidget {
  final QuestionsModel questionsModel;
  final index;

  const GroupQuestionIndex({
    Key? key,
    required this.index,
    required this.questionsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupQuizController>(
      init: Get.find<GroupQuizController>(),
      builder: (controller) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () => controller.scrollToQuestion(index),
            child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: Colors.grey.withOpacity(0.7)),
                  color: controller.getColorForQuestion(questionsModel.id!),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: controller
                            .getColorForTextQuestion(questionsModel.id!)),
                  ),
                )),
          )),
    );
  }
}
