import 'package:get/get.dart';

import '../../root/controllers/root_controller.dart' show RootController;

class AccountController extends GetxController {
  @override
  void onInit() {
    Get.find<RootController>().getNotificationsCount();
    super.onInit();
  }
}

class GetxController {
}
