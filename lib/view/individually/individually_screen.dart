import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Components/subject_card.dart';
import '../../controllers/individually_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../Components/individually_specialize_chip.dart';
import '../Components/no_internet_screen.dart';
import '../home/home_page.dart';
import '../quiz/quiz_prefs_screen.dart';

class IndividuallyScreen extends StatelessWidget {
  IndividuallyScreen({Key? key}) : super(key: key);
  IndividuallyController controller = Get.put(IndividuallyController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white70,
        height: size.height,
        width: double.infinity,
        child: GetBuilder<IndividuallyController>(builder: (controller) {
          if (controller.isLoading) {
            return Center(
                child: SizedBox(
                    width: size.width * 0.5,
                    child: Lottie.asset("assets/images/loading0.json")));
          } else {
            if (controller.isConnected) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Visibility(
                    visible: controller.recentSubject.id != 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          textDirection: TextDirection.rtl,
                          TextSpan(
                            style: titleTextStyle,
                            children: [
                              WidgetSpan(
                                child: SizedBox(
                                    width: size.width * 0.1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                      child: Image.asset(
                                          'assets/icons/recent.png'),
                                    )),
                              ),
                              const TextSpan(text: "المستخدمة أخيرًا")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            decoration: const BoxDecoration(),
                            height: size.height * 0.17,
                            child: controller.recentSubject.id != 0
                                ? SubjectCard(
                                    specializeIcon: controller.specializeIcon(
                                        controller
                                            .recentSubject.specializeName),
                                    gradient: controller.specializeColor(
                                        controller
                                            .recentSubject.specializeName),
                                    shadowColor: controller.chosenShadowColor(
                                        controller
                                            .recentSubject.specializeName),
                                    onTap: () async {
                                      if (await ConnectivityCheck
                                              .checkConnect() ==
                                          false) {
                                        controller.noInternet(context, size);
                                      } else {
                                        controller.setIndvSubId(
                                            controller.recentSubject.id,
                                            controller
                                                .recentSubject.subjectName,
                                            controller.recentSubject.year);
                                        Get.to(
                                          () => QuizPrefsScreen(
                                            subId: controller.recentSubject.id
                                                .toString(),
                                            subName: controller
                                                .recentSubject.subjectName,
                                          ),
                                        );
                                      }
                                    },
                                    subjectName: controller
                                        .recentSubject.subjectName
                                        .toString(),
                                    studyYear: controller.subjectYear(int.parse(
                                        controller.recentSubject.year ?? "")),
                                    subjectSpecialize: controller
                                        .recentSubject.specializeName
                                        .toString(),
                                  )
                                : const SizedBox()),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    textDirection: TextDirection.rtl,
                    TextSpan(
                      style: titleTextStyle,
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                              width: size.width * 0.1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02),
                                child: Image.asset('assets/icons/books.png'),
                              )),
                        ),
                        const TextSpan(text: "جميع المواد")
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        IndividuallySpecializeChip(
                            chipText: "الكل", chipId: "الكل"),
                        IndividuallySpecializeChip(
                            chipText: "مدني", chipId: "مدني"),
                        IndividuallySpecializeChip(
                            chipText: "جزائي", chipId: "جزائي"),
                        IndividuallySpecializeChip(
                            chipText: "دولي", chipId: "دولي"),
                        IndividuallySpecializeChip(
                            chipText: "إداري", chipId: "إداري"),
                        IndividuallySpecializeChip(
                            chipText: "تجاري", chipId: "تجاري"),
                        IndividuallySpecializeChip(
                            chipText: " احوال شخصية", chipId: "احوال شخصية "),
                        IndividuallySpecializeChip(
                            chipText: "اضافي", chipId: "اضافي"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.03),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 0,
                            childAspectRatio: 1.5,
                            maxCrossAxisExtent: size.width / 2),
                        itemCount: controller.activeSubjectList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: size.height * 0.01),
                            child: SubjectCard(
                                specializeIcon: controller.specializeIcon(
                                    controller.activeSubjectList[index]
                                        .specializeName),
                                gradient: controller.specializeColor(
                                  controller
                                      .activeSubjectList[index].specializeName,
                                ),
                                shadowColor: controller.chosenShadowColor(
                                  controller
                                      .activeSubjectList[index].specializeName,
                                ),
                                subjectName: controller
                                        .activeSubjectList[index].subjectName ??
                                    "",
                                studyYear: controller.subjectYear(int.parse(
                                    controller.activeSubjectList[index].year ??
                                        "")),
                                subjectSpecialize: controller
                                        .activeSubjectList[index]
                                        .specializeName ??
                                    "",
                                onTap: () async {
                                  if (await ConnectivityCheck.checkConnect() ==
                                      false) {
                                    controller.noInternet(context, size);
                                  } else {
                                    controller.setIndvSubId(
                                        controller.activeSubjectList[index].id,
                                        controller.activeSubjectList[index]
                                            .subjectName,
                                        controller
                                            .activeSubjectList[index].year);
                                    controller.setRecentSubjects(
                                        controller.activeSubjectList[index].id);
                                    Get.to(() => QuizPrefsScreen(
                                        subId: controller
                                            .activeSubjectList[index].id
                                            .toString(),
                                        subName: controller
                                            .activeSubjectList[index]
                                            .subjectName));
                                  }
                                }),
                          );
                        }),
                  ),
                ],
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
        }));
  }
}
