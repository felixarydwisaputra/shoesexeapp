import 'package:get/get.dart';

import '../controllers/brands_controller.dart';

class BrandsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandsController>(
      () => BrandsController(),
    );
  }
}
