import 'package:get/get.dart';

import '../controllers/homestore_controller.dart';

class HomestoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomestoreController>(
      () => HomestoreController(),
    );
  }
}
