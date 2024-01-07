import 'package:get/get.dart';
import 'package:suaal_plus/controllers/create_group_controller.dart';

import '../controllers/edit_profile_controller.dart';
import '../controllers/signup_controller.dart';

validInput(String val, int min, int max, String type) {
  if (type == "phoneNumber") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "رقم هاتف غير صالح";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "بريد إلكتروني غير صالح";
    }
  }
  if (val.isEmpty) {
    return "لا يمكن أن يكون هذا الحقل فارغًا";
  }
  if (val.length > max) {
    return "لا يمكن أن يكون هذا الحقل أكثر من $max حرف ";
  }
  if (val.length < min) {
    return "لا يمكن أن يكون هذا الحقل أقل من $min حرف ";
  }
}

validUsername(String val, int min, int max) {
  SignupController regController = Get.find();
  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  if (!hasMatch(val,
      r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_ ]+[0-9\._\-]*$')) {
    return "اسم مستخدم غير صالح";
  }
  //check if username is already exist
  if (regController.usernameCheckMessage == "Username is already exist") {
    return "هذا الاسم مستخدم من قبل شخص آخر";
  }
}

validPhone(String val, int min, int max) {
  SignupController regController = Get.find();

  //check if username is already exist
  if (regController.phoneCheckMessage == "Phone is already exist") {
    return "هذا الحساب موجود بالفعل";
  }
}

validNewUsername(String val, int min, int max, String currentVal) {
  EditProfileController editController = Get.find();
  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  if (val != currentVal) {
    if (!hasMatch(val,
        r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]+[0-9\._\-]*$')) {
      return "اسم مستخدم غير صالح";
    }
    //check if username is already exist
    if (editController.usernameCheckMessage == "Username is already exist") {
      return "هذا الاسم مستخدم من قبل شخص آخر";
    }
  }
}

validNewPassword(String val, int min, int max) {
  if (val.isNotEmpty) {
    if (val.length > max) {
      return "لا يمكن أن يكون هذا الحقل أكثر من $max حرف ";
    }
    if (val.length < min) {
      return "لا يمكن أن يكون هذا الحقل أقل من $min حرف ";
    }
  }
}

validCurrentPassword(String val, int min, int max, String currentVal) {
  if (val.isEmpty) {
    return "لا يمكن أن يكون هذا الحقل فارغًا";
  }
  if (val != currentVal) {
    return "كلمة المرور خاطئة";
  }
  if (val.length > max) {
    return "لا يمكن أن يكون هذا الحقل أكثر من $max حرف ";
  }
  if (val.length < min) {
    return "لا يمكن أن يكون هذا الحقل أقل من $min حرف ";
  }
}

validGroupPasswordInput(String val) {
  if (val.isEmpty) {
    return "لا يمكن أن يكون هذا الحقل فارغًا";
  }
}
