import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/models/coupon_model.dart';
import 'package:suaal_plus/services/coupons_services.dart';
import 'package:suaal_plus/view/Components/elevated_btn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/connectivity_check.dart';
import '../view/Components/no_internet_dialog.dart';

class CouponsController extends GetxController {
  bool isLoading = false;
  bool isConnected = false;
  final storage = const FlutterSecureStorage();
  String token = "";
  int userId = 0;
  String couponsId = "";
  int showCase = 0;

  List<Coupon> items = [];
  List<Coupon> newFavItems = [];
  List newFavItemsId = [];

  hideShowCase() {
    showCase = 1;
    update();
  }

  getUserTokenAndId() async {
    String? value = (await storage.read(key: 'token'));
    String? value1 = (await storage.read(key: 'userId'));

    if (value != null) {
      token = value;
    }
    if (value1 != null) {
      userId = int.parse(value1);
    }

    update();
  }

  phoneCallLaunch(number) async {
    if (await canLaunchUrl(Uri.parse('tel://$number'))) {
      await launch('tel://$number');
    }
  }

  facebookUrlLaunch(id) async {
    if (await canLaunchUrl(Uri.parse('fb://$id'))) {
      await launch('fb://$id');
    }
  }

  whatsappUrlLaunch(number) async {
    if (await canLaunchUrl(Uri.parse("https://wa.me/+963$number/"))) {
      await launch("https://wa.me/+963$number/");
    }
  }

  telegramUrlLaunch(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launch(url);
    }
  }

  getCouponsDetails() async {
    isLoading = true;
    update();
    await getUserTokenAndId();
    try {
      var couponsData =
          await CouponsServices.couponRequest(token, userId.toString());
      for (Map<String, dynamic> i in couponsData) {
        items.add(Coupon.fromJson(i));
        update();
      }

      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  senCoupons(BuildContext context, Size size) async {
    isLoading = true;
    update();
    try {
      var sendCouponsData = await CouponsServices.senCouponRequest(
          token, userId.toString(), couponsId);
      if (sendCouponsData != null) {
        showDialog(
            context: context,
            builder: (controller) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text(
                  "تمت المفاضلة بنجاح...",
                  style: TextStyle(
                      fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                ),
                actions: [
                  Center(
                    child: SizedBox(
                        width: size.width * 0.3,
                        child: ElevatedBtn(
                            text: "تم",
                            fontSize: 16.sp,
                            press: () {
                              Get.back();
                            })),
                  )
                ],
              );
            });
      }
    } finally {
      couponsId = "";
      checkInternet();
      isLoading = false;
      update();
    }
  }

  void reOrder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex--;
    }
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    newFavItems.clear();
    newFavItemsId.clear();
    newFavItems.addAll(items);
    for (var i in newFavItems) {
      newFavItemsId.add(i.id.toString());
    }

    couponsId = "";
    for (int i = 0; i < newFavItemsId.length; i++) {
      couponsId = "$couponsId${newFavItemsId[i]},";
    }

    update();
  }

  checkInternet() async {
    if (await ConnectivityCheck.checkConnect() == true) {
      isConnected = true;
      update();
    } else {
      isConnected = false;
      update();
    }
  }

  void noInternet(BuildContext context, Size size) {
    showNoInternetDialog(context, size);
  }

  Future<dynamic> showNoInternetDialog(BuildContext context, Size size) {
    return showDialog(
        context: context, builder: (context) => const NoInternetDialog());
  }

  @override
  void onInit() {
    checkInternet();
    getCouponsDetails();
    super.onInit();
  }
}
