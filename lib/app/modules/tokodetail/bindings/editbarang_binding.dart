import 'package:get/get.dart';

import '../controllers/editbarang_controller.dart';

class EditbarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditbarangController>(
      () => EditbarangController(),
    );
  }
}
