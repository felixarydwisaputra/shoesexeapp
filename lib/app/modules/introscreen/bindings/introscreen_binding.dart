import 'package:get/get.dart';

import '../controllers/introscreen_controller.dart';

class IntroscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroscreenController>(
      () => IntroscreenController(),
    );
  }
}
