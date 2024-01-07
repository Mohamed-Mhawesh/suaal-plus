import 'package:get/get.dart';

import '../controllers/create_group_controller.dart';

validGroupName(String val, int min, int max) {
  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  if (!hasMatch(val,
      r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_ ]+[0-9\._\-]*$')) {
    return "اسم مجموعة غير صالح";
  }
  CreateGroupController createGroupController = Get.find();
  if (createGroupController.groupNameCheckMessage ==
      "this name is already used") {
    return "هذا الاسم مستخدم لمجموعة أخرى";
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

validGroupPassword(String val, int min, int max) {
  if (val.isNotEmpty) {
    if (val.length > max) {
      return "لا يمكن أن يكون هذا الحقل أكثر من $max حرف ";
    }
    if (val.length < min) {
      return "لا يمكن أن يكون هذا الحقل أقل من $min حرف ";
    }
  }
}
