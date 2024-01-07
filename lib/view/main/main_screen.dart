import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/view/Components/specialize_chip.dart';
import 'package:suaal_plus/view/Components/subject_card.dart';
import 'package:suaal_plus/view/Components/user_avatar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:suaal_plus/view/home/home_page.dart';
import 'package:suaal_plus/view/quiz/quiz_prefs_screen.dart';
import '../../controllers/home_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../../theme/constants.dart';
import '../Components/no_internet_screen.dart';
import '../Components/simple_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print("main screen rebuild");
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
            child: SizedBox(
                width: size.width * 0.5,
                child: Lottie.asset("assets/images/loading0.json")));
      } else {
        if (controller.isConnected.value) {
          return Container(
              height: size.height,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(child: GetBuilder<HomeController>(
                        builder: (controller) {
                          {
                            return AnimationLimiter(
                              child: CarouselSlider.builder(
                                  itemCount: controller
                                          .advertisementImagesList.isNotEmpty
                                      ? controller
                                          .advertisementImagesList.length
                                      : 1,
                                  itemBuilder: (context, index, realIndex) {
                                    final myImage = controller
                                            .advertisementImagesList.isNotEmpty
                                        ? controller
                                            .advertisementImagesList[index]
                                        : "https://images.pexels.com/photos/3996362/pexels-photo-3996362.jpeg";
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: FadeInAnimation(
                                        child: buildImage(
                                            size,
                                            myImage,
                                            index,
                                            controller.advertisementList
                                                    .isNotEmpty
                                                ? controller
                                                    .advertisementList[index]
                                                    .isText
                                                : 0,
                                            controller.advertisementList
                                                    .isNotEmpty
                                                ? controller
                                                    .advertisementList[index]
                                                    .description
                                                : "", () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    backgroundColor: Colors
                                                        .transparent
                                                        .withOpacity(0.1),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    titlePadding:
                                                        const EdgeInsets.all(0),
                                                    title: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              "https://suaalplus.sy/public/img/${controller.advertisementList[index].img}",
                                                              fit: BoxFit.cover,
                                                            ))),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            controller
                                                                .advertisementList[
                                                                    index]
                                                                .description,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    16.sp),
                                                          )),
                                                          const Divider(
                                                            color: Colors.white,
                                                          ),
                                                          Visibility(
                                                            visible: controller
                                                                    .advertisementList[
                                                                        index]
                                                                    .phone !=
                                                                null,
                                                            child: SimpleShadow(
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        size.height *
                                                                            0.01,
                                                                    horizontal:
                                                                        size.width *
                                                                            0.02),
                                                                width:
                                                                    size.width *
                                                                        0.7,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .white),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    controller.phoneCallLaunch(controller
                                                                        .advertisementList[
                                                                            index]
                                                                        .phone);
                                                                  },
                                                                  child:
                                                                      Text.rich(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            16.sp,
                                                                      ),
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child: SizedBox(
                                                                              width: size.width * 0.1,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                                child: Image.asset('assets/icons/phone.png'),
                                                                              )),
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              "اتصل الآن",
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          Visibility(
                                                            visible: controller
                                                                    .advertisementList[
                                                                        index]
                                                                    .facebook !=
                                                                null,
                                                            child: SimpleShadow(
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        size.height *
                                                                            0.01,
                                                                    horizontal:
                                                                        size.width *
                                                                            0.02),
                                                                width:
                                                                    size.width *
                                                                        0.7,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .white),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    controller.facebookUrlLaunch(controller
                                                                        .advertisementList[
                                                                            index]
                                                                        .facebook);
                                                                  },
                                                                  child:
                                                                      Text.rich(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            16.sp,
                                                                      ),
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child: SizedBox(
                                                                              width: size.width * 0.1,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                                child: Image.asset('assets/icons/facebook.png'),
                                                                              )),
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              "زيارة صفحة الفيسبوك",
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          Visibility(
                                                            visible: controller
                                                                    .advertisementList[
                                                                        index]
                                                                    .whatsApp !=
                                                                null,
                                                            child: SimpleShadow(
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        size.height *
                                                                            0.01,
                                                                    horizontal:
                                                                        size.width *
                                                                            0.02),
                                                                width:
                                                                    size.width *
                                                                        0.7,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .white),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    controller.whatsappUrlLaunch(controller
                                                                        .advertisementList[
                                                                            index]
                                                                        .whatsApp);
                                                                  },
                                                                  child:
                                                                      Text.rich(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            16.sp,
                                                                      ),
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child: SizedBox(
                                                                              width: size.width * 0.1,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                                child: Image.asset('assets/icons/whatsapp.png'),
                                                                              )),
                                                                        ),
                                                                        const TextSpan(
                                                                          text:
                                                                              "مراسلة عبر واتساب",
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          Visibility(
                                                            visible: controller
                                                                    .advertisementList[
                                                                        index]
                                                                    .telegram !=
                                                                null,
                                                            child: SimpleShadow(
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        size.height *
                                                                            0.01,
                                                                    horizontal:
                                                                        size.width *
                                                                            0.02),
                                                                width:
                                                                    size.width *
                                                                        0.7,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .white),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    controller.telegramUrlLaunch(controller
                                                                        .advertisementList[
                                                                            index]
                                                                        .telegram);
                                                                  },
                                                                  child:
                                                                      Text.rich(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            16.sp,
                                                                      ),
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child: SizedBox(
                                                                              width: size.width * 0.1,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                                child: Image.asset('assets/icons/telegram.png'),
                                                                              )),
                                                                        ),
                                                                        const TextSpan(
                                                                            text:
                                                                                "مراسلة عبر تلغرام")
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: const [],
                                                  ));
                                        }),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                      autoPlayInterval:
                                          const Duration(seconds: 10),
                                      height: size.height * 0.25,
                                      viewportFraction: 0.98,
                                      autoPlay: true,
                                      enlargeCenterPage: true)),
                            );
                          }
                        },
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 24.h,
                              margin: EdgeInsets.only(
                                  bottom: 2.h, right: 8.w, left: 8.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "الأفضل تقييمًا",
                                    style: titleTextStyle,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.seeAll(3);
                                      },
                                      child: Text(
                                        "شاهد الكل",
                                        style: textButtonTextStyle.copyWith(
                                            fontSize: 14.sp),
                                      ))
                                ],
                              ),
                            ),
                            GetBuilder<HomeController>(
                                builder: (controller) => Container(
                                      height: 100.h,
                                      child: AnimationLimiter(
                                        child: ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.h),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                controller.topTenList.length,
                                            itemBuilder: (context, index) {
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: SlideAnimation(
                                                  horizontalOffset: -100.w,
                                                  child: FadeInAnimation(
                                                    duration: const Duration(
                                                        milliseconds: 600),
                                                    child: UserAvatar(
                                                      radius:
                                                          size.height * 0.04,
                                                      imageName: controller
                                                              .topTenList[index]
                                                              .avatar ??
                                                          "avatar_1.png",
                                                      text: controller
                                                          .topTenList[index]
                                                          .username
                                                          .toString(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    )),
                            Container(
                              height: 24.h,
                              margin: EdgeInsets.only(
                                  bottom: 2.h, right: 8.w, left: 8.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "موادي",
                                    style: titleTextStyle,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.seeAll(4);
                                      },
                                      child: Text(
                                        "شاهد الكل",
                                        style: textButtonTextStyle.copyWith(
                                            fontSize: 14.sp),
                                      ))
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: GetBuilder<HomeController>(
                                  builder: (controller) => Row(
                                    children: [
                                      SpecializeChip(
                                          chipText: "الكل", chipId: "الكل"),
                                      SpecializeChip(
                                          chipText: "مدني", chipId: "مدني"),
                                      SpecializeChip(
                                          chipText: "جزائي", chipId: "جزائي"),
                                      SpecializeChip(
                                          chipText: "دولي", chipId: "دولي"),
                                      SpecializeChip(
                                          chipText: "إداري", chipId: "إداري"),
                                      SpecializeChip(
                                          chipText: "تجاري", chipId: "تجاري"),
                                      SpecializeChip(
                                          chipText: " احوال شخصية",
                                          chipId: "احوال شخصية "),
                                      SpecializeChip(
                                          chipText: "اضافي", chipId: "اضافي"),
                                    ],
                                  ),
                                )),
                            GetBuilder<HomeController>(
                              builder: (controller) => Container(
                                decoration: const BoxDecoration(),
                                height: 120.h,
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.008),
                                      itemCount:
                                          controller.activeSubjectList.length,
                                      itemBuilder: (context, index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration: const Duration(
                                              milliseconds: 1200),
                                          child: SlideAnimation(
                                            horizontalOffset: -100.w,
                                            child: FadeInAnimation(
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              child: SubjectCard(
                                                specializeIcon: controller
                                                    .specializeIcon(controller
                                                        .activeSubjectList[
                                                            index]
                                                        .specializeName),
                                                gradient: controller
                                                    .specializeColor(controller
                                                        .activeSubjectList[
                                                            index]
                                                        .specializeName),
                                                shadowColor: controller
                                                    .chosenShadowColor(
                                                        controller
                                                            .activeSubjectList[
                                                                index]
                                                            .specializeName),
                                                onTap: () async {
                                                  if (await ConnectivityCheck
                                                          .checkConnect() ==
                                                      false) {
                                                    controller.noInternet(
                                                        context, size);
                                                  } else {
                                                    controller.setIndividuallySubId(
                                                        controller
                                                            .activeSubjectList[
                                                                index]
                                                            .id,
                                                        controller
                                                            .activeSubjectList[
                                                                index]
                                                            .subjectName,
                                                        controller
                                                            .activeSubjectList[
                                                                index]
                                                            .year);
                                                    // controller.setRecentSubjects(
                                                    //     controller.activeSubjectList[index].id);
                                                    Get.to(() => QuizPrefsScreen(
                                                        subId: controller
                                                            .activeSubjectList[
                                                                index]
                                                            .id
                                                            .toString(),
                                                        subName: controller
                                                            .activeSubjectList[
                                                                index]
                                                            .subjectName));
                                                    // print(
                                                    //     "=====${controller.activeSubjectList[index].year}");
                                                    // controller.setIndividuallySubId(
                                                    //     controller
                                                    //         .activeSubjectList[index].id,
                                                    //     controller
                                                    //         .activeSubjectList[index]
                                                    //         .subjectName,
                                                    //     controller
                                                    //         .activeSubjectList[index]
                                                    //         .year);
                                                    // Get.to(() => QuizPrefsScreen(
                                                    //       subId: controller
                                                    //           .activeSubjectList[index].id
                                                    //           .toString(),
                                                    //       subName: controller
                                                    //           .activeSubjectList[index]
                                                    //           .subjectName,
                                                    //     ));
                                                  }
                                                },
                                                subjectName: controller
                                                    .activeSubjectList[index]
                                                    .subjectName
                                                    .toString(),
                                                studyYear:
                                                    controller.userStudyYear,
                                                subjectSpecialize: controller
                                                    .activeSubjectList[index]
                                                    .specializeName
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]));
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

Widget buildImage(Size size, String image, int index, int? isText, String text,
    void Function()? onTap) {
  HomeController controller = Get.find();
  return InkWell(
    onTap: onTap,
    child: Container(
        height: size.height * 0.3,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.4),
                offset: const Offset(0, 2),
                blurRadius: 4)
          ],
        ),
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
          vertical: size.height * 0.01,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              controller.advertisementImagesList.isNotEmpty
                  ? "https://suaalplus.sy/public/img/$image"
                  : image,
              fit: BoxFit.cover,
            ))),
  );
  //}
}
