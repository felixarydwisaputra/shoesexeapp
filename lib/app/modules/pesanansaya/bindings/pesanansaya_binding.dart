import 'package:get/get.dart';

import '../controllers/pesanansaya_controller.dart';

class PesanansayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesanansayaController>(
      () => PesanansayaController(),
    );
  }
}
