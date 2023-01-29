import 'package:get/get.dart';

import '../controllers/tambahbarang_controller.dart';

class TambahbarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahbarangController>(
      () => TambahbarangController(),
    );
  }
}
