import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:suaal_plus/view/Components/simple_shadow.dart';
import 'package:suaal_plus/view/Groups/groups_screen.dart';
import 'package:suaal_plus/view/edit_profile/edit_profile_screen.dart';
import 'package:suaal_plus/view/main/main_screen.dart';
import 'package:suaal_plus/view/Coupons/coupons_screen.dart';
import 'package:suaal_plus/view/notifications/notifcations_screen.dart';
import 'package:suaal_plus/view/sorting/sorting_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/home_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../individually/individually_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeController controller = Get.put(HomeController());

  //int currentIndex = 2;
  final screens = [
    MainScreen(),
    GroupsScreen(),
    CouponsScreen(),
    SortingScreen(),
    IndividuallyScreen(),
  ];
  int chosenTab = 1; //for drawer

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    Size size = MediaQuery.of(context).size;
    print("height:${size.height}");
    print("width:${size.width}");

    return SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(44.h),
            child: AppBar(
              iconTheme: const IconThemeData(color: kPrimaryColor),
              actions: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "${controller.endIn}",
                          style: GoogleFonts.cairo(
                              height: 1, color: kPrimaryColor),
                        ),
                        Text("يوم",
                            style: GoogleFonts.cairo(
                                height: 1, color: kPrimaryColor)),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => NotificationsScreen());
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.01,
                            right: size.width * 0.03,
                            left: size.width * 0.01),
                        width: size.width * 0.08,
                        child: Image.asset("assets/icons/notification.png"),
                      ),
                      Visibility(
                        visible: controller.newNotifications,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(bottom: size.width * 0.02),
                            width: size.width * 0.05,
                            child: Lottie.asset("assets/images/CirclePop.json"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.01,
                        right: size.width * 0.03,
                        left: size.width * 0.03),
                    width: size.width * 0.1,
                    child: Image.asset("assets/icons/menu.png"),
                  ),
                ),
              ],
              flexibleSpace: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    SimpleShadow(
                      child: GetBuilder<HomeController>(builder: (controller) {
                        if (controller.getUsernameAndStdYearIsLoading) {
                          return Center(
                            child: SizedBox(
                                width: size.width * 0.2,
                                child: Lottie.asset(
                                    "assets/images/loading0.json")),
                          );
                        } else {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.001,
                                  vertical: size.height * 0.002),
                              child: SizedBox(
                                width: size.width * 0.14,
                                child: Image.network(
                                    "https://suaalplus.sy/public/img/${controller.userAvatar}"),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("مرحبًا",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold)),
                        GetBuilder<HomeController>(
                          builder: (controller) => Text(controller.userName,
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 14.sp,
                                  color: kSecondColor,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              elevation: 0,
            ),
          ),
          endDrawer: Drawer(
            width: size.width * 0.7,
            backgroundColor: kPrimaryColor,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff8586ff), Color(0xff8586ff)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              height: size.height,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    padding: EdgeInsets.only(top: size.height * 0.01),
                    child: GetBuilder<HomeController>(builder: (controller) {
                      if (controller.getUsernameAndStdYearIsLoading) {
                        return Center(
                          child: SizedBox(
                              width: size.width * 0.2,
                              child:
                                  Lottie.asset("assets/images/loading0.json")),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: Image.network(
                                  "https://suaalplus.sy/public/img/${controller.userAvatar}"),
                            ),
                            Text(
                              controller.userName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            Text(
                              controller.userStudyYear,
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState?.closeEndDrawer();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: chosenTab == 1
                                          ? kLightColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.07,
                                        height: size.height * 0.04,
                                        child: Image.asset(
                                            "assets/icons/home.png"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "الصفحة الرئيسية",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (await ConnectivityCheck.checkConnect() ==
                                      false) {
                                    controller.noInternet(context, size);
                                  } else {
                                    Get.offAll(() => EditProfileScreen());
                                  }

                                  // });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: chosenTab == 2
                                          ? kLightColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.07,
                                        height: size.height * 0.04,
                                        child: Image.asset(
                                            "assets/icons/edit.png"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "تعديل الحساب",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Share.share(controller.inviteText);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.07,
                                        height: size.height * 0.04,
                                        child: Image.asset(
                                            "assets/icons/invite.png"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "دعوة صديق",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  //   setState(() {
                                  //   chosenTab=2;
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    controller.privacyText,
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.5,
                                                      child: ElevatedBtn(
                                                          text: "تم",
                                                          fontSize: 16.sp,
                                                          press: () {
                                                            Get.back();
                                                          }))
                                                ],
                                              ),
                                            ),
                                          ));

                                  // });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: chosenTab == 2
                                          ? kLightColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.07,
                                        height: size.height * 0.04,
                                        child: Image.asset(
                                            "assets/icons/privacy.png"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "سياسة الخصوصية",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  //   setState(() {
                                  //   chosenTab=2;
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    controller.privacyText,
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.5,
                                                      child: ElevatedBtn(
                                                          text: "تم",
                                                          fontSize: 16.sp,
                                                          press: () {
                                                            Get.back();
                                                          }))
                                                ],
                                              ),
                                            ),
                                          ));

                                  // });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: chosenTab == 2
                                          ? kLightColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.07,
                                        height: size.height * 0.04,
                                        child: Image.asset(
                                            "assets/icons/terms.png"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "شروط الاستخدام",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            title: Text(
                                              "هل تريد تسجيل الخروج؟",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: size.width * 0.2,
                                                      child: ElevatedBtn(
                                                          text: "نعم",
                                                          fontSize: 16.sp,
                                                          color: Colors.red,
                                                          press: () {
                                                            controller.logout();
                                                          })),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.2,
                                                      child: ElevatedBtn(
                                                          text: "لا",
                                                          fontSize: 16.sp,
                                                          press: () {
                                                            Get.back();
                                                          }))
                                                ],
                                              )
                                            ],
                                          ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.07,
                                        height: size.height * 0.04,
                                        child: Image.asset(
                                            "assets/icons/logout.png"),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "تسجيل الخروج",
                                        style: TextStyle(fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     const Divider(),
                          //
                          //     SizedBox(
                          //       height: size.height * 0.02,
                          //     ),
                          //     Container(
                          //       padding: const EdgeInsets.all(8),
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(6)),
                          //       child: Row(
                          //         children: [
                          //           const Icon(Icons.contact_phone),
                          //           SizedBox(
                          //             width: size.width * 0.02,
                          //           ),
                          //           const Text(
                          //             "اتصل بنا",
                          //             style: TextStyle(fontSize: 16),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: size.height * 0.02,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //    backgroundColor: kPrimaryColor,
          bottomNavigationBar:
              GetBuilder<HomeController>(builder: (controller) {
            return Container(
              height: size.height * 0.1,
              color: Colors.white70,
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.03),
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                backgroundColor: Colors.white70,
                textStyle: TextStyle(
                    fontSize: size.width * 0.04,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
                iconSize: size.width * 0.06,
                color: kLightColor,
                activeColor: kPrimaryColor,
                tabBackgroundColor: kLightColor,
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.04),
                selectedIndex: controller.currentPage,
                onTabChange: (index) {
                  controller.navigateToPage(index);
                  print(controller.currentPage);
                },
                tabs: [
                  GButton(
                    leading: SizedBox(
                      width: size.width * 0.07,
                      height: size.height * 0.04,
                      child: Image.asset("assets/icons/home.png"),
                    ),
                    text: "الرئيسية",
                    icon: Icons.home,
                  ),
                  GButton(
                    leading: SizedBox(
                      width: size.width * 0.09,
                      height: size.height * 0.05,
                      child: Image.asset("assets/icons/groups.png"),
                    ),
                    text: "المجموعات",
                    icon: Icons.home,
                  ),
                  GButton(
                    leading: SizedBox(
                      width: size.width * 0.07,
                      height: size.height * 0.04,
                      child: Image.asset("assets/icons/gift.png"),
                    ),
                    text: "القسائم",
                    icon: Icons.home,
                  ),
                  GButton(
                    leading: SizedBox(
                      width: size.width * 0.09,
                      height: size.height * 0.05,
                      child: Image.asset("assets/icons/ranking.png"),
                    ),
                    text: "الترتيب",
                    icon: Icons.home,
                  ),
                  GButton(
                    leading: SizedBox(
                      width: size.width * 0.07,
                      height: size.height * 0.04,
                      child: Image.asset("assets/icons/quiz.png"),
                    ),
                    text: "الاختبار",
                    icon: Icons.home,
                  ),
                ],
              ),
            );

            //   BottomNavigationBar(
            //   elevation: 0,
            //   currentIndex: controller.currentPage,
            //   onTap: (index) => controller.navigateToPage(index),
            //   backgroundColor:  Colors.white70,
            //   selectedItemColor: kPrimaryColor,
            //   unselectedItemColor: kPrimaryColor.withOpacity(0.4),
            //   items: const [
            //     BottomNavigationBarItem(
            //         label: "الترتيب", icon: Icon(Icons.star)),
            //     BottomNavigationBarItem(
            //         label: "مجموعات", icon: Icon(Icons.group)),
            //     BottomNavigationBarItem(
            //         label: "الرئيسية", icon: Icon(Icons.home_filled)),
            //     BottomNavigationBarItem(
            //       label: "فردي",
            //       icon: Icon(Icons.person),
            //     ),
            //     BottomNavigationBarItem(
            //       label: "القسائم",
            //       icon: Icon(Icons.payment_rounded),
            //     )
            //   ],
            // );
          }),
          body: GetBuilder<HomeController>(builder: (controller) {
            return Stack(
              children: [
                screens[controller.currentPage],
                Visibility(
                  visible: !controller.isEndSemester,
                  child: Container(
                    height: size.height,
                    color: Colors.transparent.withOpacity(0.8),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1,
                              vertical: size.height * 0.05),
                          child: Text(
                            "اضغط مطولًا  على القسيمة وانقلها إلى ترتيبها الجديد لإعادة ترتيب قائمة تفضيلات القسائم الخاصة بك",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.3,
                            width: double.infinity,
                            child: Lottie.asset("assets/images/drag.json")),
                        SizedBox(
                            width: size.width * 0.6,
                            child: ElevatedBtn(
                              text: "حسنًا",
                              fontSize: 16.sp,
                              press: () {},
                              color: Colors.white,
                              textColor: kPrimaryColor,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          }));
    }));
  }
}
