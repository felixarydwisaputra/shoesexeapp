import 'package:get/get.dart';

import 'package:shoesexe/app/modules/checkout/controllers/alamat_controller.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlamatController>(
      () => AlamatController(),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
  }
}
