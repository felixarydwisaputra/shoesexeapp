import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutkeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutkeranjangController>(
      () => CheckoutkeranjangController(),
    );
  }
}
