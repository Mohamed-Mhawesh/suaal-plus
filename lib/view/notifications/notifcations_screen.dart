import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:suaal_plus/controllers/notifications_controller.dart';
import 'package:suaal_plus/theme/constants.dart';

import '../Components/notification_card.dart';
import '../home/home_page.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);
  NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NotificationsController>(builder: (controller) {
      if (controller.isLoading) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: SizedBox(
                  width: size.width * 0.5,
                  child: Lottie.asset("assets/images/loading0.json")),
            ),
          ),
        );
      } else {
        return SafeArea(
          child: Scaffold(
            body: RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: () async {
                await controller.getNotifications();
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.02),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: size.width * 0.03,
                                    left: size.width * 0.01),
                                width: size.width * 0.08,
                                child: Image.asset(
                                    "assets/icons/notification.png"),
                              ),
                              Text(
                                "الإشعارات",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                                vertical: size.height * 0.02),
                            child: IconButton(
                                onPressed: () {
                                  Get.offAll(() => const HomePage());
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                  size: size.width * 0.1,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.notificationsList.length,
                          itemBuilder: (context, index) {
                            return NotificationCard(
                              size: size,
                              id: controller.notificationsList[index].id,
                              title: controller.notificationsList[index].title,
                              description: controller
                                  .notificationsList[index].description,
                              roundId:
                                  controller.notificationsList[index].roundId,
                              showTime:
                                  controller.notificationsList[index].showTime,
                              hadSeen:
                                  controller.notificationsList[index].hadSeen,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
