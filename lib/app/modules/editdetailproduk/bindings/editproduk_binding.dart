import 'package:get/get.dart';

import '../controllers/editproduk_controller.dart';

class EditprodukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditprodukController>(
      () => EditprodukController(),
    );
  }
}
