import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:suaal_plus/controllers/group_quiz_controller.dart';
import 'package:suaal_plus/view/Components/group_question_card.dart';
import 'package:suaal_plus/view/home/home_page.dart';

class GroupWrongScreen extends StatelessWidget {
  GroupWrongScreen({Key? key}) : super(key: key);
  static const routeName = '/wrong_screen';
  GroupQuizController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.delete<GroupQuizController>();
        await Get.offAll(() => const HomePage());
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<GroupQuizController>(
            init: GroupQuizController(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.13,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    GroupQuestionIndex(
                                  questionsModel: controller.questions[index],
                                  index: index,
                                ),
                                itemCount: controller.questions.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ScrollablePositionedList.builder(
                                itemScrollController: controller.itemController,
                                itemPositionsListener:
                                    controller.itemPositionsListener,
                                addAutomaticKeepAlives: false,
                                itemBuilder: (context, index) => GroupWrongCard(
                                  questionsModel: controller.questions[index],
                                  index: index,
                                ),
                                itemCount: controller.questions.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
