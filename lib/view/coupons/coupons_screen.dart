import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/theme/constants.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import '../../controllers/coupons_controller.dart';
import '../../helpers/connectivity_check.dart';
import '../Components/no_internet_screen.dart';
import '../Components/simple_shadow.dart';
import '../home/home_page.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  CouponsController controller = Get.put(CouponsController());

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CouponsController>(builder: (controller) {
      if (controller.isLoading) {
        return Center(
          child: SizedBox(
              width: size.width * 0.5,
              child: Lottie.asset("assets/images/loading0.json")),
        );
      } else {
        if (controller.isConnected) {
          return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ReorderableListView.builder(
                          itemCount: controller.items.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.all(10),
                              key: Key("${controller.items[index].id}"),
                              width: double.infinity,
                              height: 80.h,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.01),
                                      child: SizedBox(
                                        height: size.height * 0.1,
                                        width: size.width * 0.2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://suaalplus.sy/public/img/${controller.items[index].logo}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        size.height * 0.01,
                                                    horizontal:
                                                        size.width * 0.01),
                                                child: Text.rich(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 12.sp,
                                                    ),
                                                    children: [
                                                      WidgetSpan(
                                                        child: SizedBox(
                                                          width:
                                                              size.width * 0.1,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        size.width *
                                                                            0.02),
                                                            child: Image.asset(
                                                                'assets/icons/company.png'),
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: controller
                                                            .items[index]
                                                            .companyName,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.03,
                                                    vertical:
                                                        size.height * 0.01),
                                                child: Text(
                                                  controller.items[index].title,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              child: SizedBox(
                                                width: size.width * 0.14,
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Lottie.asset(
                                                          "assets/images/click.json"),
                                                    ),
                                                    Center(
                                                      child: SizedBox(
                                                        width:
                                                            size.width * 0.04,
                                                        child: Image.asset(
                                                            "assets/icons/details.png"),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
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
                                                    title: Stack(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            child:
                                                                Image.network(
                                                              "https://suaalplus.sy/public/img/${controller.items[index].logo}",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //
                                                    //   children: [
                                                    //     SizedBox(
                                                    //
                                                    //        width: size.width*0.06
                                                    //
                                                    //        , child: Image.asset('assets/icons/gift-card.png')),
                                                    //
                                                    //     Text(
                                                    //         "أدخل كلمة المرور ",style: TextStyle(fontSize: size.width*0.04,fontWeight: FontWeight.bold),),
                                                    //   ],
                                                    // ),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text.rich(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  TextSpan(
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.sp,
                                                                    ),
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              size.width * 0.08,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: size.width * 0.01),
                                                                            child:
                                                                                Image.asset('assets/icons/company.png'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: controller
                                                                            .items[index]
                                                                            .companyName,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01,
                                                                ),
                                                                Text.rich(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  TextSpan(
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.sp,
                                                                    ),
                                                                    children: [
                                                                      WidgetSpan(
                                                                        child: SizedBox(
                                                                            width: size.width * 0.08,
                                                                            child: Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                                                                              child: Image.asset('assets/icons/gift.png'),
                                                                            )),
                                                                      ),
                                                                      TextSpan(
                                                                        text: controller
                                                                            .items[index]
                                                                            .title,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              controller
                                                                  .items[index]
                                                                  .description,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            color: Colors.white,
                                                          ),
                                                          Visibility(
                                                            visible: controller
                                                                    .items[
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
                                                                    print(controller
                                                                        .items[
                                                                            index]
                                                                        .phone);
                                                                    controller.phoneCallLaunch(controller
                                                                        .items[
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
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                size.width * 0.1,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                              child: Image.asset('assets/icons/phone.png'),
                                                                            ),
                                                                          ),
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
                                                                    .items[
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
                                                                    print(controller
                                                                        .items[
                                                                            index]
                                                                        .facebook);
                                                                    controller.facebookUrlLaunch(controller
                                                                        .items[
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
                                                                    .items[
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
                                                                    print(controller
                                                                        .items[
                                                                            index]
                                                                        .whatsApp);
                                                                    controller.whatsappUrlLaunch(controller
                                                                        .items[
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
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                size.width * 0.1,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                              child: Image.asset('assets/icons/whatsapp.png'),
                                                                            ),
                                                                          ),
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
                                                                    .items[
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
                                                                    print(controller
                                                                        .items[
                                                                            index]
                                                                        .telegram);
                                                                    controller.telegramUrlLaunch(controller
                                                                        .items[
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
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                size.width * 0.1,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                                                              child: Image.asset('assets/icons/telegram.png'),
                                                                            ),
                                                                          ),
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
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            controller.reOrder(oldIndex, newIndex);
                          },
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: controller.couponsId != "",
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SimpleShadow(
                            child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          width: size.width * 0.5,
                          height: 50.h,
                          child: FloatingActionButton(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),

                            onPressed: () async {
                              if (await ConnectivityCheck.checkConnect() ==
                                  false) {
                                controller.noInternet(context, size);
                              } else {
                                controller.senCoupons(context, size);
                              }
                            },
                            child: Text(
                              "حفظ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                      )),
                  Visibility(
                    visible: controller.showCase == 0,
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
                                press: () {
                                  controller.hideShowCase();
                                },
                                color: Colors.white,
                                textColor: kPrimaryColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ));
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
