import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class GroupResultController extends GetxController {
  final storage = const FlutterSecureStorage();
  bool isLoading = false;
  String token = "";
  String userId = "";

  getUserToken() async {
    String? tokenValue = (await storage.read(key: 'token'));
    String? userIdValue = (await storage.read(key: 'userId'));
    if (tokenValue != null) {
      token = tokenValue;
      userId = userIdValue!;
    }
    update();
  }
}
