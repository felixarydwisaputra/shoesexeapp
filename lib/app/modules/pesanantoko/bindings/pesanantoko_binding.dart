import 'package:get/get.dart';

import '../controllers/pesanantoko_controller.dart';

class PesanantokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanantokoController>(
      () => PesanantokoController(),
    );
  }
}
