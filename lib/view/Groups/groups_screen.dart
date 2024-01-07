import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/controllers/groups_controller.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Components/group_card.dart';
import 'package:suaal_plus/view/Components/groups_choice_chip.dart';
import 'package:suaal_plus/view/Groups/create_group_screen.dart';

import '../Components/no_internet_screen.dart';
import '../Components/rounded_input_field.dart';
import '../home/home_page.dart';

class GroupsScreen extends StatelessWidget {
  GroupsScreen({Key? key}) : super(key: key);

  GroupsController controller = Get.put(GroupsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<GroupsController>(builder: (controller) {
      if (controller.isLoading) {
        return Center(
          child: SizedBox(
              width: size.width * 0.5,
              child: Lottie.asset("assets/images/loading0.json")),
        );
      } else {
        if (controller.isConnected) {
          return Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: RoundedInputField(
                          icon: Icons.search,
                          controller: controller.editingController,
                          hintText: "ابحث حسب اسم المادة",
                          kbType: TextInputType.name,
                          onChanged: (value) {
                            print('val=$value');
                            controller.filterSearchResults(value);
                          },
                          valid: (val) {}),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GroupChoiceChip(
                            chipText: "أنشأتها", chipId: 1, process: "gr"),
                        GroupChoiceChip(
                            chipText: "مجموعاتي", chipId: 2, process: "gr"),
                        GroupChoiceChip(
                            chipText: "المجموعات", chipId: 3, process: "gr")
                      ],
                    ),
                    RefreshIndicator(
                      color: kPrimaryColor,
                      onRefresh: () async {
                        await controller.getGroups();
                      },
                      child: SizedBox(
                        height: size.height * 0.6,
                        child: ListView.builder(
                            itemCount: controller.getChosenGroupList().length,
                            itemBuilder: (context, index) {
                              return GroupCard(
                                groupId: controller
                                    .getChosenGroupList()[index]
                                    .groupId,
                                roundId: controller
                                        .getChosenGroupList()[index]
                                        .roundId ??
                                    0,
                                groupName: controller
                                    .getChosenGroupList()[index]
                                    .groupName,
                                subject: controller
                                    .getChosenGroupList()[index]
                                    .subjects,
                                usersNumber: controller
                                    .getChosenGroupList()[index]
                                    .usersNum,
                                adminName: controller
                                        .getChosenGroupList()[index]
                                        .username ??
                                    "",
                                numberOfQuestions: controller
                                    .getChosenGroupList()[index]
                                    .questionsNum,
                                startTime: controller
                                    .getChosenGroupList()[index]
                                    .fromTime,
                                endTime: controller
                                    .getChosenGroupList()[index]
                                    .toTime,
                                firstButtonText: "",
                                secondButtonText: "ddd",
                              );
                            }),
                      ),
                    ),
                  ],
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: kSecondColor,
                        child: const Icon(Icons.add),
                        onPressed: () {
                          Get.to(CreateGroupScreen());
                        }),
                  ),
                ),
                Visibility(
                  visible: controller.isDoingFunction,
                  child: Container(
                    height: size.height,
                    color: Colors.transparent.withOpacity(0.8),
                    child: Center(
                      child: SizedBox(
                          width: size.width * 0.5,
                          child: Lottie.asset("assets/images/loading0.json")),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return NoInternetScreen(
            size: size,
            tryAgain: () {
              Get.offAll(() => const HomePage());
            },
          );
        }
      }
    });
  }
}
